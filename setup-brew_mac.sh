#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Display banner
display_banner_msg "Install Homebrew"

# Install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
