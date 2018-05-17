#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

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
