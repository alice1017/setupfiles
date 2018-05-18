#!/bin/bash

# Define variables
if [ ! -z "$1" ];then
    LIBPATH="$1"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

# Load libraries
source "$LIBPATH/variables.sh"
source "$LIBPATH/utilities.sh"
source "$LIBPATH/environs.sh"
source "$LIBPATH/functions.sh"
source "$LIBPATH/logging.sh"
source "$LIBPATH/init.sh"
