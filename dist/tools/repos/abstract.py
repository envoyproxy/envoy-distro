import argparse
from abc import abstractmethod

import abstracts


class ARepoManager(metaclass=abstracts.Abstraction):
    file_types: str = r"^$"

    @classmethod
    @abstractmethod
    def add_arguments(cls, parser: argparse.ArgumentParser):
        parser.add_argument("--deb_aptly_command", nargs="?")

    @abstractmethod
    def __init__(self, path, config, log, stdout, **kwargs):
        raise NotImplementedError

    @abstractmethod
    async def publish(self):
        raise NotImplementedError
