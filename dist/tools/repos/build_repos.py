#!/bin/env python3

import argparse
import asyncio
import pathlib
import re
import subprocess
import sys
from functools import cached_property, partial
from itertools import chain
from typing import Dict, List, Optional, Pattern, Set, Type

import yaml

import aiohttp

from gidgethub.aiohttp import GitHubAPI

from tools.base.aio import async_subprocess
from tools.base.functional import async_property
from tools.base import aio, runner
from tools.github import runner as github_runner, release_manager

APTLY_COMMAND = "external/com_github_aptly_dev_aptly/aptly_/aptly"
PUBLISH_YAML = "publish.yaml"


class DebRepoError(Exception):
    pass


class RepoReleaseManager(release_manager.GithubReleaseManager):

    def __init__(self, *args, **kwargs):
        self.session = kwargs.pop("session")
        super().__init__(*args, **kwargs)

    @cached_property
    def asset_types(self) -> Dict[str, Pattern[str]]:
        return dict(
            deb=re.compile(r".*(\.deb|\.changes)$"),
            rpm=re.compile(r".*\.rpm$"))

    @async_property(cache=True)
    async def assets(self) -> List[dict]:
        assets = []
        for asset in await super().assets:
            asset_type = self.asset_type(asset)
            if not asset_type:
                continue
            asset["asset_type"] = asset_type
            assets.append(asset)
        return assets

    @async_property(cache=True)
    async def release(self) -> dict:
        return await self.get_release()

    def asset_type(self, asset: dict) -> Optional[str]:
        for k, v in self.asset_types.items():
            if v.search(asset["name"]):
                return k


class RepoManager:

    def __init__(self, path, config, log, stdout):
        self.path = path
        self._config = config
        self.log = log
        self.stdout = stdout

    @cached_property
    def config(self):
        return self._config

    async def publish(self):
        raise NotImplementedError


class DebRepoManager(RepoManager):

    def __init__(self, *args, **kwargs):
        self._aptly_command = kwargs.pop("aptly_command", None)
        super().__init__(*args, **kwargs)

    @property
    def aptly_command(self) -> str:
        return self._aptly_command or APTLY_COMMAND

    @cached_property
    def changes_files(self) -> List[pathlib.Path]:
        return [x for x in self.path.glob("deb/*.changes")]

    @cached_property
    def config(self) -> Dict[str, List[str]]:
        return {k: v["deb"] for k, v in self._config.items() if "deb" in v}

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
        result = await async_subprocess.run(command, capture_output=True, encoding="utf-8")

        if result.returncode:
            raise DebRepoError(f"Error running aptly ({command}):\n{result.stderr}")

        if result.stderr.strip():
            self.stdout.info(result.stderr)

        return result.stdout

    async def distro_exists(self, distro: str) -> bool:
        return bool(distro in await self.repos)

    async def publish(self) -> None:
        self.log.notice("Building deb repository")

        for distro in self.distros:
            if await self.distro_exists(distro):
                repos = await self.repos
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
                await self.aptly("publish", "drop", distro)
                try:
                    await self.aptly("snapshot", "drop", "-force", distro)
                except DebRepoError:
                    pass

            result = await self.aptly("snapshot", "create", distro, "from", "repo", distro)
            self.log.success(result.split("\n")[-1])

            result = await self.aptly("publish", "snapshot", f"-distribution=\"{distro}\"", "-architectures=\"amd64,arm64\"", distro)
            self.log.success(result.strip().split("\n")[-1])

        for version, package_types in self.config.items():
            self.log.notice(f"Creating deb repo for version: {version}")
            for distro in package_types:
                self.log.notice(f"Publishing packages ({distro}) for version: {version}")


class RPMRepoManager(RepoManager):

    async def publish(self):
        self.log.warning("TODO! Add createrepo for rpms...")


class RepoBuildingRunner(github_runner.GithubRunner):

    @cached_property
    def config(self) -> Dict[str, Dict[str, list]]:
        return yaml.safe_load(pathlib.Path(PUBLISH_YAML).read_text())

    @property
    def path(self) -> pathlib.Path:
        return pathlib.Path(self.tempdir.name)

    @property
    def oauth_token(self) -> Optional[str]:
        if not self.oauth_token_file.exists():
            return
        return self.oauth_token_file.read_text().strip()

    @cached_property
    def release_managers(self) -> Dict[str, release_manager.GithubReleaseManager]:
        return {
            version: self.release_manager_class(
                self.github,
                version,
                self.path,
                self.repository,
                self.log,
                session=self.session,
                continues=self.continues)
            for version in self.config}

    @property
    def release_manager_class(self) -> Type[release_manager.GithubReleaseManager]:
        return RepoReleaseManager

    @cached_property
    def repos(self) -> Dict[str, RepoManager]:
        return dict(
            deb=DebRepoManager(self.path, self.config, self.log, self.stdout, aptly_command=self.args.deb_aptly_command),
            rpm=RPMRepoManager(self.path, self.config, self.log, self.stdout))

    def add_arguments(self, parser: argparse.ArgumentParser):
        super().add_arguments(parser)
        parser.add_argument("--deb_aptly_command", nargs="?")
        parser.add_argument("--archive", nargs="?")

    async def cleanup(self):
        await self.session.close()
        await super().cleanup()

    @runner.cleansup
    async def run(self) -> Optional[int]:
        for manager in self.release_managers.values():
            await manager.fetch()
        for repo in self.repos.values():
            await repo.publish()
        # todo: fix me
        pathlib.Path(self.args.archive).write_text("xxx")


def main(*args: str) -> Optional[int]:
    return asyncio.run(RepoBuildingRunner(*args).run())


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
