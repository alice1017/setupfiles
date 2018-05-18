#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# exec script
script_name="$(get_script_name "zsh")"
bash "$(pwd)/$script_name"
