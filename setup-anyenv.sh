#!/bin/bash

# Load library
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

# make the script name & execute
script_name=$(make_script_path "anyenv")
exec_script $script_name

# check exit code
if has "anyenv";then
    log_pass "anyenv installation was successful."

else
    log_fail "anyenv installation was failed."
fi
