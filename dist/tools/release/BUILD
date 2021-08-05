load("@envoy//tools/base:envoy_python.bzl", "envoy_py_command")
load("@release_pip3//:requirements.bzl", "requirement")

licenses(["notice"])  # Apache 2


envoy_py_command(
    name = "dist.tools.distribution.release",
    command_main = "envoy.distribution.release",
    deps = [
        requirement("envoy.distribution.release"),
    ],
)
