 #!/bin/env python3

import argparse
import sys
from typing import Optional

from envoy.base import runner, utils


class ConfigRunner(runner.Runner):

    @property
    def key(self):
        return self.args.key

    def add_arguments(self, parser: argparse.ArgumentParser) -> None:
        super().add_arguments(parser)
        parser.add_argument("key")

    def run(self):
        if self.key == "versions":
            print("1.19 1.20")
        elif self.key == "repo":
            print("phlax/release-testing")
        elif self.key == "asset-types":
            print(r"deb:.*(\.deb|\.changes)$ rpm:.*\.rpm$")


def main(*args: str) -> Optional[int]:
    return ConfigRunner(*args).run()


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
