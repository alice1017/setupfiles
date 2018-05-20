#!/bin/bash

# Define library
if [ "$(uname)" = "Darwin" ];then
    HERE="$(dirname $(bin/greadlink -f $0))"
else
    HERE="$(dirname $(readlink -f $0))"
fi

SCRIPTS="$(ls "$HERE" | grep -v "_" | grep "setup-")"

# Load library
source "$HERE/lib/load.sh"

# display banner
display_banner

# execute scripts
echo $SCRIPTS | xargs -n 1 bash
