#!/bin/bash

# Load libraries
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

# check the git is exists
if ! has "git";then
    bash "$(pwd)/setup-git_mac.sh"
fi

# Display banner
display_banner_msg "Install anyenv from source"

# Define variables
URL="https://github.com/riywo/anyenv"

ANYENV_ROOT="${HOME}/.anyenv"
ANYENV="${ANYENV_ROOT}/bin/anyenv"

PYENV_ROOT="${ANYENV_ROOT}/envs/pyenv"
PYENV="${PYENV_ROOT}/bin/pyenv"

RBENV_ROOT="${ANYENV_ROOT}/envs/rbenv"
NDENV_ROOT="${ANYENV_ROOT}/envs/ndenv"

clean() {
    :
}

# clone
execute_cmd "git clone -q ${URL} ${ANYENV_ROOT}" "/tmp/anyenv-clone.log"

# exec anyenv init
eval "$($ANYENV init -)"
export ANYENV_ROOT
export PYENV_ROOT
export RBENV_ROOT
export NDENV_ROOT

# mkdir
mkdir -p "$ANYENV_ROOT/envs/pyenv/versions"
mkdir -p "$ANYENV_ROOT/envs/rbenv/versions"
mkdir -p "$ANYENV_ROOT/envs/ndenv/versions"
mkdir -p "$ANYENV_ROOT/share/"

# install envs
execute_cmd "${ANYENV} install pyenv" "/tmp/pyenv-install.log"
execute_cmd "${ANYENV} install rbenv" "/tmp/rbenv-install.log"
execute_cmd "${ANYENV} install ndenv" "/tmp/ndenv-install.log"

# pyenv install versions
execute_cmd "${PYENV} install 2.7.5" "/tmp/pyenv-install-2.7.5.log"
execute_cmd "${PYENV} install 3.6.0" "/tmp/pyenv-install-3.6.0.log"

exit 0
