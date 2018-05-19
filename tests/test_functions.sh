#!/bin/bash

# Load library
LIBPATH="$(dirname $(dirname $(readlink -f $0)))/lib"
source "$LIBPATH/load.sh" "$LIBPATH"

testcase_download() {
    download -np "http://httpbin.org" > /dev/null 2>&1
    assert_equal $? 0
    assert_true $([ -e "${SRCDIR}/httpbin.org" ])
    rm "$SRCDIR/httpbin.org"
}

testcase_findstr() {
    assert_true $(findstr "abs" "a")
    assert_true $(findstr "abs" "b")
    assert_true $(findstr "abs" "s")
    assert_true $(findstr "abs" "ab")
    assert_true $(findstr "abs" "bs")
    assert_true $(findstr "abs" "abs")
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

    assert_true $(download -np "$url" > /dev/null 2>&1)
    assert_true $([ -e "$filepath" ])
    assert_true $(extract "$filepath" > /dev/null 2>&1)
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

    assert_true $(download -np "$url" > /dev/null 2>&1)
    assert_true $([ -e "$filepath" ])
    assert_true $(extract "$filepath" > /dev/null 2>&1)
    assert_true $([ -e "$dirpath" ])

    rm "$filepath"
    rm -rf "$dirpath"
}

testcase_script_path() {
    local script=

    os_detect

    script="$(basename $(make_script_path "zsh"))"
    assert_equal "$script" "setup-zsh_${PLATFORM}.sh"
}
