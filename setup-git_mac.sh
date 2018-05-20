#!/bin/bash

# Check homebrew exists
if ! has "homebrew"; then
    bash "$(pwd)/setup-brew_mac.sh"
fi

# Display banner
display_banner_msg "Install git by Homebrew"

# Install
homebrew install git
