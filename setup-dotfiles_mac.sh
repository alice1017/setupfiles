#!/bin/bash

# Load libraries
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

# Display banner
display_banner_msg "Install dotfiles and create symlinks"

# Define variables and function
URL="git@github.com:alice1017/dotfiles.git"
DESTPATH="$HOME/dotfiles"

clean() {
    :
}

# check the git is exists
if ! has "git";then
    bash "$(pwd)/setup-git_mac.sh"
fi

# clone
execute_cmd "git clone -q ${URL} ${DESTPATH}" "/tmp/dotfiles-clone.log"

# move dir
echo "Moved directory from "$(pwd)" to "$(ink "yellow" "$DESTPATH")""
cd "$DIRPATH"

# execute command
make install
exit $?
