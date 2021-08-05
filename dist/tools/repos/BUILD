load("@envoy//tools/base:envoy_python.bzl", "envoy_py_binary")

licenses(["notice"])  # Apache 2

envoy_py_binary(
    name = "dist.tools.repos.build_repos",
    data = [
        "//:publish.yaml",
        "@com_github_aptly_dev_aptly//:aptly",
    ],
    envoy_prefix = "@envoy",
    deps = [
        "@envoy//tools/base:aio",
        "@envoy//tools/base:functional",
        "@envoy//tools/base:runner",
        "@envoy//tools/base:utils",
        "@envoy//tools/github:release_manager",
        "@envoy//tools/github:runner",
    ],
)
