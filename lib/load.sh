#!/bin/bash

# Define variables
if [ ! -z "$1" ];then
    LIBPATH="$1"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

# Load libraries
source "$LIBPATH/env.sh"
source "$LIBPATH/vars.sh"
source "$LIBPATH/functions.sh"
source "$LIBPATH/init.sh"
