#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# make the script name & execute
script_name=$(make_script_path "zsh")
exec_script $script_name

# check exit code
if has "zsh";then
    log_pass "Zsh installation was successful."
else
    log_fail "Zsh installation was failed."
fi
