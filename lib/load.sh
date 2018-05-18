#!/bin/bash

# Define variables
LIBPATH="$(dirname $(readlink -f $0))/lib"

# Load libraries
source "$LIBPATH/env.sh"
source "$LIBPATH/vars.sh"
source "$LIBPATH/functions.sh"
source "$LIBPATH/init.sh"
