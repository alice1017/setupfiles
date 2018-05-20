#!/bin/bash

# Load library
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

# make the script name & execute
script_name=$(make_script_path "vim")
exec_script $script_name

# check exit code
if has "vim";then
    log_pass "Vim installation was successful."
else
    log_fail "Vim installation was failed."
fi
