#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# exec script
exec_script "zsh"
