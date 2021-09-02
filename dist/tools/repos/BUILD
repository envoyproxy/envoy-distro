load("@rules_python//python:defs.bzl", "py_binary", "py_library")
load("@envoy//tools/base:envoy_python.bzl", "envoy_py_binary", "envoy_py_library", "envoy_py_command")
load("@repos_pip3//:requirements.bzl", "requirement")
load("@repos_dev_pip3//:requirements.bzl", dev_requirement = "requirement")

licenses(["notice"])  # Apache 2

py_library(
    name = "abstract",
    srcs = ["abstract.py"],
)

envoy_py_binary(
    name = "dist.tools.repos.config",
    deps = [
        requirement("envoy.base.runner"),
        requirement("envoy.base.utils"),
    ],
    data = ["//:publish.yaml"],
)

envoy_py_command(
    name = "dist.tools.repos.build",
    command_main = "envoy.distribution.repo",
    deps = [
        dev_requirement("envoy.distribution.repo"),
    ],
    data = [
        "//:publish.yaml",
        "@com_github_aptly_dev_aptly//:aptly",
    ],
    envoy_prefix = "@envoy",
)
