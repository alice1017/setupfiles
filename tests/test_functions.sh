#!/bin/bash

# Load library
LIBPATH="$(dirname $(dirname $(readlink -f $0)))/lib"
source "$LIBPATH/load.sh" "$LIBPATH"

testcase_download() {
    download "http://httpbin.org"
    assert_equal $? 0
    assert_true $(test -e "${SRCDIR}/index.html")
    rm "$SRCDIR/index.html"
}

testcase_search_string() {
    assert_true $(search_string "abs" "a")
    assert_true $(search_string "abs" "b")
    assert_true $(search_string "abs" "s")
    assert_true $(search_string "abs" "ab")
    assert_true $(search_string "abs" "bs")
    assert_true $(search_string "abs" "abs")
}

testcase_archive_detect() {
    assert_equal $(archive_detect "a.tar.gz") "tar.gz"
    assert_equal $(archive_detect "a.zip") "zip"
}

testcase_extract_tar() {
    local url="https://github.com/ueokande/bashtub/archive/v0.2.tar.gz"
    local file="$(basename "$url")"
    local dir="bashtub-0.2"
    local filepath="${SRCDIR}/${file}"
    local dirpath="${SRCDIR}/${dir}"

    assert_true $(download "$url")
    assert_true $([ -e "$filepath" ])
    assert_true $(extract "$filepath")
    assert_true $([ -e "$dirpath" ])

    rm "$filepath"
    rm -rf "$dirpath"
}

testcase_extract_zip() {
    local url="https://github.com/alice1017/setupscripts/archive/master.zip"
    local file="$(basename "$url")"
    local dir="setupscripts-master"
    local filepath="${SRCDIR}/${file}"
    local dirpath="${SRCDIR}/${dir}"

    assert_true $(download "$url")
    assert_true $([ -e "$filepath" ])
    assert_true $(extract "$filepath")
    assert_true $([ -e "$dirpath" ])

    rm "$filepath"
    rm -rf "$dirpath"
}

testcase_script_name() {
    # normal test
    script_name=$(get_script_name "zsh")
    assert_equal "$script_name" "setup-zsh_linux.sh"

    # if platform is not-supported os
    os_detect
    if [ "$PLATFORM" = "bsd" ];then
        script_name=$(get_script_name "zsh")
        assert_equal "$?" "1"
    fi
}
