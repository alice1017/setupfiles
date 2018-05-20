#!/bin/bash

# Define variables
if [ ! -z "$1" ];then
    LIBPATH="$1"

else
    if [ "$(uname)" = "Darwin" ];then
        LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
    else
        LIBPATH="$(dirname $(readlink -f $0))/lib"
    fi

fi

# Load libraries
source "$LIBPATH/logging.sh"
source "$LIBPATH/utilities.sh"
source "$LIBPATH/variables.sh"
source "$LIBPATH/environs.sh"
source "$LIBPATH/build.sh"
source "$LIBPATH/init.sh"
