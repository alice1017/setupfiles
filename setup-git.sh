#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# make the script name & execute
script_name=$(make_script_path "git")
exec_script $script_name

# check exit code
if has "git";then
    log_pass "Git installation was successful."
else
    log_fail "Git installation was failed."
fi
