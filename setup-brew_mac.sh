#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

# Define variables
RUBY="/usr/bin/ruby"
URL="https://raw.githubusercontent.com/Homebrew/install/master/install"

CMD="${RUBY} -e $(curl -fsSL ${URL}) > /dev/null 2>&1"

# Install
$SPINNER "$CMD" "" "Installing homebrew"
