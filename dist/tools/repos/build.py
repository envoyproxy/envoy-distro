#!/bin/env python3

import argparse
import asyncio
import json
import os
import pathlib
import pwd
import re
import sys
import tarfile

from functools import cached_property
from itertools import chain
from typing import Dict, List, Optional, Pattern, Set, Type

from aio.functional import async_property

from envoy.base import runner, utils

from dist.tools.repos import deb, repo, rpm
from dist.tools.repos.abstract import ARepoManager

PUBLISH_YAML = "publish.yaml"


class RepoBuildingRunner(runner.Runner):
    create_releases: bool = False
    _repo_types = ()

    @classmethod
    def register_repo_type(cls, name: str, util: Type[ARepoManager]) -> None:
        """Register a repo type"""
        cls._repo_types = getattr(cls, "_repo_types") + ((name, util),)

    @property
    def asset_types(self) -> Dict[str, Pattern[str]]:
        return {k: re.compile(v.file_types) for k, v in self.repo_types.items()}

    @cached_property
    def path(self) -> pathlib.Path:
        return pathlib.Path(self.tempdir.name)

    @cached_property
    def repo_types(self) -> Dict[str, Type[ARepoManager]]:
        return dict(self._repo_types)

    @cached_property
    def repos(self) -> Dict[str, ARepoManager]:
        return {
            repo_type: manager(
                self.path, self.release_config, self.log, self.stdout, **self._kwargs_for_type(repo_type))
            for repo_type, manager in self.repo_types.items()}

    def add_arguments(self, parser: argparse.ArgumentParser) -> None:
        super().add_arguments(parser)
        parser.add_argument("--packages", nargs="*")
        parser.add_argument("--archive", nargs="?")
        for manager in self.repo_types.values():
            manager.add_arguments(parser)

    async def cleanup(self):
        super().cleanup()

    def create_archive(self, *paths) -> None:
        if not self.args.archive:
            return
        with tarfile.open(self.args.archive, "w") as tar:
            for path in paths:
                if path:
                    tar.add(path, arcname=".")

    @runner.cleansup
    async def run(self) -> Optional[int]:
        created = []

        for packages in self.args.packages:
            utils.extract(self.path, packages)

        for repo in self.repos.values():
            created.append(await repo.publish())
        self.create_archive(*created)

    def _kwargs_for_type(self, repo_type: str) -> dict:
        return {
            k[len(repo_type) + 1:]: v
            for k, v in vars(self.args).items()
            if k.startswith(f"{repo_type}_")}

    @cached_property
    def release_config(self) -> Dict[str, Dict[str, list]]:
        if not self.release_config_file.exists():
            raise repo.RepoError("Unable to find release configuration: {self.release_config_file}")

        result = utils.from_yaml(self.release_config_file)

        if not isinstance(result, dict):
            raise repo.RepoError("Unable to parse release configuration: {self.release_config_file}")

        return result

    @property
    def release_config_file(self) -> pathlib.Path:
        return pathlib.Path(PUBLISH_YAML)

# Setup


def _register_repo_types() -> None:
    RepoBuildingRunner.register_repo_type("deb", deb.DebRepoManager)
    RepoBuildingRunner.register_repo_type("rpm", rpm.RPMRepoManager)


def main(*args: str) -> Optional[int]:
    _register_repo_types()
    return asyncio.run(RepoBuildingRunner(*args).run())


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
