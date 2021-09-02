import argparse
import asyncio
import pathlib
import re
import sys
import tarfile
from functools import cached_property
from typing import Dict, List, Optional, Pattern, Type

from dist.tools.repos.abstract import ARepoManager


# Repo classes are used by the dist site
class RepoError(Exception):
    pass


class BaseRepoManager:
    """Base class for RepoManagers - eg to build apt or yum repositories."""

    file_types: str = r"^$"

    @classmethod
    def add_arguments(cls, parser: argparse.ArgumentParser):
        pass

    def __init__(self, path, config, log, stdout, **kwargs):
        self.path = path
        self._config = config
        self.log = log
        self.stdout = stdout

    @cached_property
    def config(self):
        return self._config
