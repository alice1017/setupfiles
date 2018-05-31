#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Display banner
display_banner_msg "Install anyenv from source"

# Define variables
URL="https://github.com/riywo/anyenv"
DESTPATH="${HOME}/.anyenv"
ANYENV="${DESTPATH}/bin/anyenv"
PYENV="${DESTPATH}/envs/pyenv/bin/pyenv"

clean() {
    :
}

# check the git is exists
if ! has "git";then
    bash "$(pwd)/setup-git_linux.sh"
fi

# clone
execute_cmd "git clone -q ${URL} ${DESTPATH}" "/tmp/anyenv-clone.log"

# mkdir
mkdir -v -p $DESTPATH/envs/pyenv
mkdir -v -p $DESTPATH/envs/rbenv
mkdir -v -p $DESTPATH/envs/ndenv
mkdir -v -p $DESTPATH/share/

# install envs
execute_cmd "${ANYENV} install pyenv" "/tmp/pyenv-install.log"
execute_cmd "${ANYENV} install rbenv" "/tmp/rbenv-install.log"
execute_cmd "${ANYENV} install ndenv" "/tmp/ndenv-install.log"

# pyenv install versions
execute_cmd "${PYENV} install 2.7.5" "/tmp/pyenv-install-2.7.5.log"
execute_cmd "${PYENV} install 3.6.0" "/tmp/pyenv-install-3.6.0.log"

exit 0
