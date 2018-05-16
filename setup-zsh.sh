#!/bin/bash

# Define variables
LIBPATH="$HOME/setupfiles/lib/"

# Load scripts
source "$LIBPATH/env.sh"

# detect os -> exec shell script
os_detect

# exec bash shell script without bsd & unknown platform
if ! is_bsd || is_unknown; then

    script_name=$(printf "setup-zsh_%s.sh" "$PLATFORM")
    bash "$(PWD)/$script_name"

fi
