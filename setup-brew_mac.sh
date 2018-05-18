#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

# Display banner
display_banner_msg "Install zsh by homebrew"

# Install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
