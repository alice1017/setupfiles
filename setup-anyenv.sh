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

# check exists anyenv
if [ -e "$HOME/.anyenv" ];then
    log_pass "anyenv installation was successful."

else
    log_fail "anyenv installation was failed."
fi

# check exists pyenv
if [ -e "$HOME/.anyenv/envs/pyenv" ];then
    log_pass "pyenv installation was successful."

    if [ -e "$HOME/.anyenv/envs/pyenv/versions/2.7.5" ];then
        log_pass "Python 2.7.5 installation was successful."
    else
        find "$HOME/.anyenv/envs/"
        log_fail "Python 2.7.5 installation was failed."
    fi

    if [ -e "$HOME/.anyenv/envs/pyenv/versions/3.6.0" ];then
        log_pass "Python 3.6.0 installation was successful."
    else
        log_fail "Python 3.6.0 installation was failed."
    fi

else
    log_fail "pyenv installation was failed."
fi

# check exists rbenv
if [ -e "$HOME/.anyenv/envs/rbenv" ];then
    log_pass "rbenv installation was successful."

else
    log_fail "rbenv installation was failed."
fi

# check exists ndenv
if [ -e "$HOME/.anyenv/envs/ndenv" ];then
    log_pass "rbenv installation was successful."

else
    log_fail "rbenv installation was failed."
fi
