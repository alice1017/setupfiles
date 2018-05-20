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

# Display banner
display_banner_msg "Install git by Homebrew"

# brew update
brew update

# Install
brew install git
