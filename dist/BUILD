
genrule(
    name = "packages",
    outs = ["packages.tar"],
    cmd = """
    cat $(location //:fetch.key) | base64 --decode > /tmp/fetch.key \
    && VERSIONS=($$($(location //dist/tools/repos:config) versions)) \
    && RELEASE_REPO=$$($(location //dist/tools/repos:config) repo) \
    && ASSET_TYPES=($$($(location //dist/tools/repos:config) asset-types)) \
    && $(location //dist/tools/release:release) \
        "$${RELEASE_REPO}" /tmp/fetch.key fetch "$${VERSIONS[@]}" \
        --path $@ \
        --asset-type "$${ASSET_TYPES[@]}" \
        --continue
    """,
    tools = [
        "//dist/tools/release:release",
        "//:fetch.key",
        "//dist/tools/repos:config",
    ],
)

genrule(
    name = "repos",
    outs = ["repos.tar"],
    cmd = """
    $(location //dist/tools/repos:build) \
        --packages $(location :packages) \
        --deb_aptly_command=$(location @com_github_aptly_dev_aptly//:aptly) \
        --archive=$@
    """,
    tools = [
        ":packages",
        "//:publish.yaml",
        "//dist/tools/repos:build",
        "@com_github_aptly_dev_aptly//:aptly",
    ],
)

genrule(
    name = "html",
    outs = ["site.tar"],
    cmd = """
    rm -rf /tmp/out \
    && mkdir -p /tmp/out \
    && tar xf $(location :repos) -C /tmp/out \
    && tar -chf $@ -C /tmp/out .
    """,
    tools = [
        ":repos",
    ],
)
