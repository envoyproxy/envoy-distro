load("@bazel_gazelle//:deps.bzl", "go_repository")

def aptly_dependencies():
    go_repository(
        name = "com_github_aptly_dev_aptly",
        importpath = "github.com/aptly-dev/aptly",
        sum = "h1:6N8931mh2TvHeSMBePd8TR8du2jCWCDzRmbDw1eD7/g=",
        version = "v1.4.0",
    )

    go_repository(
        name = "com_github_aleksi_pointer",
        importpath = "github.com/AlekSi/pointer",
        sum = "h1:KWCWzsvFxNLcmM5XmiqHsGTTsuwZMsLFwWF9Y+//bNE=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_awalterschulze_gographviz",
        importpath = "github.com/awalterschulze/gographviz",
        sum = "h1:24jix3mqu421BBMWbVBOl5pDw0f9ncazW10kaMywzHQ=",
        version = "v0.0.0-20160912181450-761fd5fbb34e",
    )

    go_repository(
        name = "com_github_aws_aws_sdk_go",
        importpath = "github.com/aws/aws-sdk-go",
        sum = "h1:MyXUdCesJLBvSSKYcaKeeEwxNUwUpG6/uqVYeH/Zzfo=",
        version = "v1.25.0",
    )

    go_repository(
        name = "com_github_cheggaaa_pb",
        importpath = "github.com/cheggaaa/pb",
        sum = "h1:CNg2511WECXZ7Ja6jjyz9CMBpQOrMuP5+H5zfjgVi/Q=",
        version = "v1.0.10",
    )

    go_repository(
        name = "com_github_davecgh_go_spew",
        importpath = "github.com/davecgh/go-spew",
        sum = "h1:ZDRjVQ15GmhC3fiQ8ni8+OwkZQO4DARzQgrnXU1Liz8=",
        version = "v1.1.0",
    )

    go_repository(
        name = "com_github_disposaboy_jsonconfigreader",
        importpath = "github.com/DisposaBoy/JsonConfigReader",
        sum = "h1:rv5qJCfIzQhhefHp8MO98hoGRI3mdps2iiGA3o4nm8A=",
        version = "v0.0.0-20130112093355-33a99fdf1d5e",
    )

    go_repository(
        name = "com_github_fatih_color",
        importpath = "github.com/fatih/color",
        sum = "h1:DkWD4oS2D8LGGgTQ6IvwJJXSL5Vp2ffcQg58nFV38Ys=",
        version = "v1.7.0",
    )

    go_repository(
        name = "com_github_fsnotify_fsnotify",
        importpath = "github.com/fsnotify/fsnotify",
        sum = "h1:IXs+QLmnXW2CcXuY+8Mzv/fWEsPGWxqefPtCP5CnV9I=",
        version = "v1.4.7",
    )

    go_repository(
        name = "com_github_gin_contrib_sse",
        importpath = "github.com/gin-contrib/sse",
        sum = "h1:AzN37oI0cOS+cougNAV9szl6CVoj2RYwzS3DpUQNtlY=",
        version = "v0.0.0-20170109093832-22d885f9ecc7",
    )

    go_repository(
        name = "com_github_gin_gonic_gin",
        importpath = "github.com/gin-gonic/gin",
        sum = "h1:Gm6bjW5SQ/sIib9Zcgyyw5chSE6SLcgVZIflI0qGI6s=",
        version = "v1.1.5-0.20170702092826-d459835d2b07",
    )

    go_repository(
        name = "com_github_golang_protobuf",
        importpath = "github.com/golang/protobuf",
        sum = "h1:P3YflyNX/ehuJFLhxviNdFxQPkGK5cDcApsge1SqnvM=",
        version = "v1.2.0",
    )

    go_repository(
        name = "com_github_golang_snappy",
        importpath = "github.com/golang/snappy",
        sum = "h1:Qgr9rKW7uDUkrbSmQeiDsGa8SjGyCOGtuasMWwvp2P4=",
        version = "v0.0.1",
    )

    go_repository(
        name = "com_github_h2non_filetype",
        importpath = "github.com/h2non/filetype",
        sum = "h1:Esu2EFM5vrzNynnGQpj0nxhCkzVQh2HRY7AXUh/dyJM=",
        version = "v1.0.5",
    )

    go_repository(
        name = "com_github_hpcloud_tail",
        importpath = "github.com/hpcloud/tail",
        sum = "h1:nfCOvKYfkgYP8hkirhJocXT2+zOD8yUNjXaWfTlyFKI=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_jlaffaye_ftp",
        importpath = "github.com/jlaffaye/ftp",
        sum = "h1:lWFup/SOhwcpvRJIFqx/WQis5U4SrOSyWfSqvfdF09w=",
        version = "v0.0.0-20180404123514-2403248fa8cc",
    )

    go_repository(
        name = "com_github_jmespath_go_jmespath",
        importpath = "github.com/jmespath/go-jmespath",
        sum = "h1:pmfjZENx5imkbgOkpRUYLnmbU7UEFbjtDA2hxJ1ichM=",
        version = "v0.0.0-20180206201540-c2b33e8439af",
    )

    go_repository(
        name = "com_github_kjk_lzma",
        importpath = "github.com/kjk/lzma",
        sum = "h1:RnWZeH8N8KXfbwMTex/KKMYMj0FJRCF6tQubUuQ02GM=",
        version = "v0.0.0-20161016003348-3fd93898850d",
    )

    go_repository(
        name = "com_github_mattn_go_colorable",
        importpath = "github.com/mattn/go-colorable",
        sum = "h1:/bC9yWikZXAL9uJdulbSfyVNIR3n3trXl+v8+1sx8mU=",
        version = "v0.1.2",
    )

    go_repository(
        name = "com_github_mattn_go_isatty",
        importpath = "github.com/mattn/go-isatty",
        sum = "h1:HLtExJ+uU2HOZ+wI0Tt5DtUDrx8yhUqDcp7fYERX4CE=",
        version = "v0.0.8",
    )

    go_repository(
        name = "com_github_mattn_go_runewidth",
        importpath = "github.com/mattn/go-runewidth",
        sum = "h1:UnlwIPBGaTZfPQ6T1IGzPI0EkYAQmT9fAEJ/poFC63o=",
        version = "v0.0.2",
    )

    go_repository(
        name = "com_github_mattn_go_shellwords",
        importpath = "github.com/mattn/go-shellwords",
        sum = "h1:5FJ7APbaUYdUTxxP/XXltfy/mICrGqugUEClfnj+D3Y=",
        version = "v1.0.2",
    )

    go_repository(
        name = "com_github_mkrautz_goar",
        importpath = "github.com/mkrautz/goar",
        sum = "h1:Iu5QFXIMK/YrHJ0NgUnK0rqYTTyb0ldt/rqNenAj39U=",
        version = "v0.0.0-20150919110319-282caa8bd9da",
    )

    go_repository(
        name = "com_github_mxk_go_flowrate",
        importpath = "github.com/mxk/go-flowrate",
        sum = "h1:y5//uYreIhSUg3J1GEMiLbxo1LJaP8RfCpH6pymGZus=",
        version = "v0.0.0-20140419014527-cca7078d478f",
    )

    go_repository(
        name = "com_github_ncw_swift",
        importpath = "github.com/ncw/swift",
        sum = "h1:CrRYmUc+mFGIvBiS5JIA4sIdURfDpJ4CGmpmR9mQAZ0=",
        version = "v1.0.30",
    )

    go_repository(
        name = "com_github_onsi_ginkgo",
        importpath = "github.com/onsi/ginkgo",
        sum = "h1:WSHQ+IS43OoUrWtD1/bbclrwK8TTH5hzp+umCiuxHgs=",
        version = "v1.7.0",
    )

    go_repository(
        name = "com_github_onsi_gomega",
        importpath = "github.com/onsi/gomega",
        sum = "h1:RE1xgDvH7imwFD45h+u2SgIfERHlS2yNG4DObb5BSKU=",
        version = "v1.4.3",
    )

    go_repository(
        name = "com_github_pborman_uuid",
        importpath = "github.com/pborman/uuid",
        sum = "h1:9J0mOv1rXIBlRjQCiAGyx9C3dZZh5uIa3HU0oTV8v1E=",
        version = "v0.0.0-20180122190007-c65b2f87fee3",
    )

    go_repository(
        name = "com_github_pkg_errors",
        importpath = "github.com/pkg/errors",
        sum = "h1:iURUrRGxPUNPdy5/HRSm+Yj6okJ6UtLINN0Q9M4+h3I=",
        version = "v0.8.1",
    )

    go_repository(
        name = "com_github_pmezard_go_difflib",
        importpath = "github.com/pmezard/go-difflib",
        sum = "h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM=",
        version = "v1.0.0",
    )

    go_repository(
        name = "com_github_smartystreets_assertions",
        importpath = "github.com/smartystreets/assertions",
        sum = "h1:voD4ITNjPL5jjBfgR/r8fPIIBrliWrWHeiJApdr3r4w=",
        version = "v1.0.1",
    )

    go_repository(
        name = "com_github_smartystreets_gunit",
        importpath = "github.com/smartystreets/gunit",
        sum = "h1:tpTjnuH7MLlqhoD21vRoMZbMIi5GmBsAJDFyF67GhZA=",
        version = "v1.0.4",
    )

    go_repository(
        name = "com_github_smira_commander",
        importpath = "github.com/smira/commander",
        sum = "h1:jLFwP6SDEUHmb6QSu5n2FHseWzMio1ou1FV9p7W6p7I=",
        version = "v0.0.0-20140515201010-f408b00e68d5",
    )

    go_repository(
        name = "com_github_smira_flag",
        importpath = "github.com/smira/flag",
        sum = "h1:OM075OkN4x9IB1mbzkzaKaJjFxx8Mfss8Z3E1LHwawQ=",
        version = "v0.0.0-20170926215700-695ea5e84e76",
    )

    go_repository(
        name = "com_github_smira_go_aws_auth",
        importpath = "github.com/smira/go-aws-auth",
        sum = "h1:VPv+J50mFyP42/GzYhGuT4MJK8w/dlLt4jkoO5yhJRs=",
        version = "v0.0.0-20180731211914-8b73995fd8d1",
    )

    go_repository(
        name = "com_github_smira_go_ftp_protocol",
        importpath = "github.com/smira/go-ftp-protocol",
        sum = "h1:rvtR4+9N2LWPo0UHe6/aHvWpqD9Dhf10P2bfGFht74g=",
        version = "v0.0.0-20140829150050-066b75c2b70d",
    )

    go_repository(
        name = "com_github_smira_go_xz",
        importpath = "github.com/smira/go-xz",
        sum = "h1:tne8XW3soRDJn4DIiqBc4jw+DPashtFMTSC9G0pC3ug=",
        version = "v0.0.0-20150414201226-0c531f070014",
    )

    go_repository(
        name = "com_github_stretchr_objx",
        importpath = "github.com/stretchr/objx",
        sum = "h1:4G4v2dO3VZwixGIRoQ5Lfboy6nUhCyYzaqnIAPPhYs4=",
        version = "v0.1.0",
    )

    go_repository(
        name = "com_github_stretchr_testify",
        importpath = "github.com/stretchr/testify",
        sum = "h1:2E4SXV/wtOkTonXsotYi4li6zVWxYlZuYNCXe9XRJyk=",
        version = "v1.4.0",
    )

    go_repository(
        name = "com_github_syndtr_goleveldb",
        importpath = "github.com/syndtr/goleveldb",
        sum = "h1:gZZadD8H+fF+n9CmNhYL1Y0dJB+kLOmKd7FbPJLeGHs=",
        version = "v1.0.1-0.20190923125748-758128399b1d",
    )

    go_repository(
        name = "com_github_ugorji_go",
        importpath = "github.com/ugorji/go",
        sum = "h1:j4s+tAvLfL3bZyefP2SEWmhBzmuIlH/eqNuPdFPgngw=",
        version = "v1.1.4",
    )

    go_repository(
        name = "com_github_ugorji_go_codec",
        importpath = "github.com/ugorji/go/codec",
        sum = "h1:7kbGefxLoDBuYXOms4yD7223OpNMMPNPZxXk5TvFcyQ=",
        version = "v1.2.6",
    )

    go_repository(
        name = "com_github_wsxiaoys_terminal",
        importpath = "github.com/wsxiaoys/terminal",
        sum = "h1:3UeQBvD0TFrlVjOeLOBz+CPAI8dnbqNSVwUwRrkp7vQ=",
        version = "v0.0.0-20160513160801-0940f3fc43a0",
    )

    go_repository(
        name = "in_gopkg_check_v1",
        importpath = "gopkg.in/check.v1",
        sum = "h1:829vOVxxusYHC+IqBtkX5mbKtsY9fheQiQn0MZRVLfQ=",
        version = "v1.0.0-20161208181325-20d25e280405",
    )

    go_repository(
        name = "in_gopkg_cheggaaa_pb_v1",
        importpath = "gopkg.in/cheggaaa/pb.v1",
        sum = "h1:n1tBJnnK2r7g9OW2btFH91V92STTUevLXYFb8gy9EMk=",
        version = "v1.0.28",
    )

    go_repository(
        name = "in_gopkg_fsnotify_v1",
        importpath = "gopkg.in/fsnotify.v1",
        sum = "h1:xOHLXZwVvI9hhs+cLKq5+I5onOuwQLhQwiu63xxlHs4=",
        version = "v1.4.7",
    )

    go_repository(
        name = "in_gopkg_go_playground_assert_v1",
        importpath = "gopkg.in/go-playground/assert.v1",
        sum = "h1:xoYuJVE7KT85PYWrN730RguIQO0ePzVRfFMXadIrXTM=",
        version = "v1.2.1",
    )

    go_repository(
        name = "in_gopkg_go_playground_validator_v8",
        importpath = "gopkg.in/go-playground/validator.v8",
        sum = "h1:lFB4DoMU6B626w8ny76MV7VX6W2VHct2GVOI3xgiMrQ=",
        version = "v8.18.2",
    )

    go_repository(
        name = "in_gopkg_h2non_filetype_v1",
        importpath = "gopkg.in/h2non/filetype.v1",
        sum = "h1:JMZLYHwIsvWGh+6UcU//eA1aiM8g4SaZm3lJweIR5Ew=",
        version = "v1.0.1",
    )

    go_repository(
        name = "in_gopkg_tomb_v1",
        importpath = "gopkg.in/tomb.v1",
        sum = "h1:uRGJdciOHaEIrze2W8Q3AKkepLTh2hOroT7a+7czfdQ=",
        version = "v1.0.0-20141024135613-dd632973f1e7",
    )

    go_repository(
        name = "in_gopkg_yaml_v2",
        importpath = "gopkg.in/yaml.v2",
        sum = "h1:ZCJp+EgiOT7lHqUV2J862kp8Qj64Jo6az82+3Td9dZw=",
        version = "v2.2.2",
    )

    go_repository(
        name = "org_golang_x_crypto",
        importpath = "golang.org/x/crypto",
        sum = "h1:Kx1Ke+iCR1aDjbWXgmEQGFxoHtNL49aRZGV7/+jJ41Y=",
        version = "v0.0.0-20180403160946-b2aa35443fbc",
    )

    go_repository(
        name = "org_golang_x_net",
        importpath = "golang.org/x/net",
        sum = "h1:nTDtHvHSdCn1m6ITfMRqtOd/9+7a3s8RBNOZ3eYZzJA=",
        version = "v0.0.0-20180906233101-161cd47e91fd",
    )

    go_repository(
        name = "org_golang_x_sync",
        importpath = "golang.org/x/sync",
        sum = "h1:wMNYb4v58l5UBM7MYRLPG6ZhfOqbKu7X5eyFl8ZhKvA=",
        version = "v0.0.0-20180314180146-1d60e4601c6f",
    )

    go_repository(
        name = "org_golang_x_sys",
        importpath = "golang.org/x/sys",
        sum = "h1:DH4skfRX4EBpamg7iV4ZlCpblAHI6s6TDM39bFZumv8=",
        version = "v0.0.0-20190222072716-a9d3bda3a223",
    )

    go_repository(
        name = "org_golang_x_text",
        importpath = "golang.org/x/text",
        sum = "h1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=",
        version = "v0.3.0",
    )
