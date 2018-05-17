#!/bin/bash

# Define variables
LIBPATH="$HOME/setupscripts/lib/"

# Load scripts
source "$LIBPATH/load.sh"

# exec script
script_name="$(get_script_name "zsh")"
bash "$script_name"
