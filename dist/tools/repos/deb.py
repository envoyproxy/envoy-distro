import argparse
import json
import pathlib
from functools import cached_property
from itertools import chain
from typing import Dict, List, Set

import abstracts

import aio.subprocess
from aio.functional import async_property

from dist.tools.repos.abstract import ARepoManager
from dist.tools.repos import repo

APTLY_COMMAND = "external/com_github_aptly_dev_aptly/aptly_/aptly"


class DebRepoError(repo.RepoError):
    pass


@abstracts.implementer(ARepoManager)
class DebRepoManager(repo.BaseRepoManager):
    file_types = r".*(\.deb|\.changes)$"

    @classmethod
    def add_arguments(cls, parser: argparse.ArgumentParser):
        parser.add_argument("--deb_aptly_command", nargs="?")

    def __init__(self, *args, **kwargs):
        self._aptly_command = kwargs.pop("aptly_command", None)
        super().__init__(*args, **kwargs)

    @async_property(cache=True)
    async def aptly_config(self) -> dict:
        return json.loads(await self.aptly("config", "show"))

    @async_property
    async def aptly_root_dir(self) -> pathlib.Path:
        return pathlib.Path((await self.aptly_config)["rootDir"])

    @property
    def aptly_command(self) -> pathlib.Path:
        command = pathlib.Path(self._aptly_command or APTLY_COMMAND)
        if not command.exists():
            raise DebRepoError(f"Unable to find aptly command: {command}")
        return command

    @cached_property
    def changes_files(self) -> List[pathlib.Path]:
        return [x for x in self.path.glob("**/deb/*.changes")]

    @cached_property
    def config(self) -> Dict[str, List[str]]:
        return {k: v["deb"] for k, v in self._config["versions"].items() if "deb" in v}

    @cached_property
    def distros(self) -> Set[str]:
        return set(chain.from_iterable(self.config.values()))

    @async_property
    async def repos(self) -> list:
        return (await self.aptly("repo", "list", "-raw")).strip().split("\n")

    @async_property
    async def snapshots(self):
        return (await self.aptly("snapshot", "list", "-raw")).strip().split("\n")

    async def aptly(self, *args: str) -> str:
        command = (self.aptly_command, ) + args
        result = await aio.subprocess.run(command, capture_output=True, encoding="utf-8")

        if result.returncode:
            raise DebRepoError(f"Error running aptly ({command}):\n{result.stderr}")

        if result.stderr.strip():
            self.log.info(result.stderr)

        return result.stdout

    async def distro_exists(self, distro: str) -> bool:
        return bool(distro in await self.repos)

    async def publish(self) -> None:
        self.log.notice("Building deb repository")

        for distro in self.distros:
            if await self.distro_exists(distro):
                self.log.warning(f"Removing existing repo {distro}")
                try:
                    await self.aptly("repo", "drop", "-force", distro)
                except DebRepoError:
                    pass

            try:
                self.log.notice(f"Creating deb distribution: {distro}")
                result = await self.aptly("repo", "create", f"-distribution=\"{distro}\"", "-component=main", distro)
                self.log.success(result.split("\n")[0])
            except DebRepoError:
                pass

            for changes_file in self.changes_files:
                if not str(changes_file).endswith(f".{distro}.changes"):
                    continue
                result = await self.aptly("repo", "include", "-no-remove-files", str(changes_file))
                self.log.success(result.strip().split("\n")[-1])

            if distro in await self.snapshots:
                self.log.warning(f"Removing existing snapshot {distro}")
                try:
                    await self.aptly("publish", "drop", distro)
                except DebRepoError:
                    pass
                try:
                    await self.aptly("snapshot", "drop", "-force", distro)
                except DebRepoError:
                    pass

            try:
                result = await self.aptly("snapshot", "create", distro, "from", "repo", distro)
                self.log.success(result.split("\n")[-1])
            except DebRepoError:
                pass

            result = await self.aptly("publish", "snapshot", f"-distribution={distro}", "-architectures=amd64,arm64", distro)
            self.log.info(result)
            # self.log.success(result.strip().split("\n")[-1])

        for version, package_types in self.config.items():
            self.log.notice(f"Creating deb repo for version: {version}")
            for distro in package_types:
                self.log.notice(f"Publishing packages ({distro}) for version: {version}")

        return await self.aptly_root_dir
