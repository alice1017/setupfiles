#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

# Check homebrew exists
if ! has "homebrew"; then
    bash "$(pwd)/setup-brew_mac.sh"
fi

# Install
$SPINNER "${INSTALL} zsh > /dev/null 2>&1" "" "Installing zsh"
