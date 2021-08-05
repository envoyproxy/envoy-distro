#!/usr/bin/env python3

import sys

from envoy.distribution import release


def main(*args: str) -> int:
    return release.main(*args)


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
