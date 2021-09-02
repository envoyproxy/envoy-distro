workspace(
    name = "envoy_distro",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

ENVOY_VERSION = "5b77ca05c8c30978ba213b31bf45080f52bff53a"

http_archive(
    name = "envoy",
    strip_prefix = "envoy-%s" % ENVOY_VERSION,
    urls = ["https://github.com/phlax/envoy/archive/%s.tar.gz" % ENVOY_VERSION],
)

load("@envoy//bazel:api_binding.bzl", "envoy_api_binding")

envoy_api_binding()

load("@envoy//bazel:api_repositories.bzl", "envoy_api_dependencies")

envoy_api_dependencies()

load("@envoy//bazel:repositories.bzl", "envoy_dependencies")

envoy_dependencies()

load("@envoy//bazel:repositories_extra.bzl", "envoy_dependencies_extra")

envoy_dependencies_extra()

load("@envoy//bazel:dependency_imports.bzl", "envoy_dependency_imports")

load("//:repositories_extra.bzl", "envoy_distro_dependencies_extra")

envoy_distro_dependencies_extra()

envoy_dependency_imports()

# gazelle:repo bazel_gazelle

load("aptly_deps.bzl", "aptly_dependencies")

aptly_dependencies()
