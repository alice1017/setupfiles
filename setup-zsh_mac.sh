#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

# Check homebrew exists
if ! has "homebrew"; then
    bash "$(pwd)/setup-brew_mac.sh"
fi

# Display banner
display_banner_msg "Install zsh by homebrew"

# Install
homebrew install zsh
