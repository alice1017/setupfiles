#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

testcase_download() {
    download "http://httpbin.org"
    test -e "$SRCDIR/index.html"
    assert_equal $? 0
    rm "$SRCDIR/index.html"
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
