#!/bin/bash

# Load libraries
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

# Check homebrew exists
if ! has "brew"; then
    bash "$(pwd)/setup-brew_mac.sh"
fi

# Define functions
is_vim_seven() {
    vim --version | grep 7 > /dev/null 2>&1
    return $?
}

install_vim() {
    brew update
    brew install vim
    exit $?
}

# Display banner
display_banner_msg "Install Vim 7 by Homebrew"

# Check already exits version
if has "vim";then
    if is_vim_seven;then
        log_pass "Vim 7 is already installed"
        exit 0
    else
        install_vim
    fi

else
    install_vim

fi
