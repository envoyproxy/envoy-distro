workspace(
    name = "envoy_distro",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "envoy",
    strip_prefix = "envoy-0af9764936e7fbc92b72933502f24f30cae86536",
    urls = ["https://github.com/envoyproxy/envoy/archive/0af9764936e7fbc92b72933502f24f30cae86536.tar.gz"],
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

envoy_dependency_imports()

# gazelle:repo bazel_gazelle

load("aptly_deps.bzl", "aptly_dependencies")

aptly_dependencies()
