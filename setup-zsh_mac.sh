#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

# Check homebrew exists
if ! has "homebrew"; then
    bash "$(PWD)/setup-brew_mac.sh"
fi

# Install
$SPINNER "${INSTALL} zsh" "" "Installing zsh"
