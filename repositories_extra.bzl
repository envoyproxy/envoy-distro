load("@rules_python//python:pip.bzl", "pip_install")

# Python dependencies.
def _python_deps():
    pip_install(
        name = "release_pip3",
        requirements = "//dist/tools/release:requirements.txt",
        extra_pip_args = ["--require-hashes"],
    )
    pip_install(
        name = "repos_pip3",
        requirements = "//dist/tools/repos:requirements.txt",
        extra_pip_args = ["--require-hashes"],
    )
    pip_install(
        name = "repos_dev_pip3",
        requirements = "//dist/tools/repos:requirements-dev.txt",
    )

def envoy_distro_dependencies_extra():
    _python_deps()
