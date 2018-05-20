#!/bin/bash

# Load library
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

# make the script name & execute
script_name=$(make_script_path "docker")
exec_script $script_name

# check exit code
if has "docker";then
    log_pass "Docker installation was successful."
else
    log_fail "Docker installation was failed."
fi
