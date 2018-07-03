#!/bin/bash

# Load library
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

if has "/usr/local/bin/git";then
    log_pass "Git was already installed."
    exit 0
fi

# make the script name & execute
script_name=$(make_script_path "git")
exec_script $script_name

# check exit code
if has "git";then
    log_pass "Git installation was successful."
else
    log_fail "Git installation was failed."
fi
