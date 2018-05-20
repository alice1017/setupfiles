#!/bin/bash

# Define library
HERE="$(dirname $(readlink -f $0))"
SCRIPTS="ls $HERE | grep -v "_" | grep "setup-""

# Load library
source "$HERE/lib/load.sh"

# display banner
display_banner

# execute scripts
echo $SCRIPTS | xargs -n 1 bash
