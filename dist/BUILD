
genrule(
    name = "repos",
    outs = ["repos.tar"],
    cmd = """
    $(location //dist/tools/repos:build_repos) \
        phlax phlax/release-testing some.key \
        --deb_aptly_command=$(location @com_github_aptly_dev_aptly//:aptly) \
        --archive=$@
    """,
    tools = [
        "//:publish.yaml",
        "//dist/tools/repos:build_repos",
        "@com_github_aptly_dev_aptly//:aptly",
    ],
)


genrule(
    name = "html",
    outs = ["site.tar"],
    cmd = """
    tar -chf $@ -C $(location //site:build) .
    """,
    tools = [
        ":repos",
        "//site:build",
    ],
)
