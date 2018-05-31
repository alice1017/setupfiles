#!/bin/bash

# Load libraries
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

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
    bash "$(pwd)/setup-git.sh"
fi

# clone
execute_cmd "git clone -q ${URL} ${DESTPATH}" "/tmp/anyenv-clone.log"

# install envs
execute_cmd "${ANYENV} install pyenv" "/tmp/pyenv-install.log"
execute_cmd "${ANYENV} install rbenv" "/tmp/rbenv-install.log"
execute_cmd "${ANYENV} install ndenv" "/tmp/ndenv-install.log"

# pyenv install versions
execute_cmd "${PYENV} install 2.7.5" "/tmp/pyenv-install-2.7.5.log"
execute_cmd "${PYENV} install 3.6.0" "/tmp/pyenv-install-3.6.0.log"

exit 0
