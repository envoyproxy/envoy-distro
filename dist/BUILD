
genrule(
    name = "html",
    outs = ["site.tar"],
    cmd = """
    mkdir -p /tmp/out \
    && echo "Helo, World" > /tmp/out/index.html \
    && tar -chf $@ -C /tmp/out .
    """,
    tools = [
        "@com_github_aptly_dev_aptly//:aptly",
    ],
)
