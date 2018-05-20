#!/bin/bash

# alias readlink if platform is mac os
if [ "$(uname)" = "Darwin" ];then
    alias readlink="bin/greadlink"
fi

# Define library
HERE="$(dirname $(readlink -f $0))"
SCRIPTS="$(ls "$HERE" | grep -v "_" | grep "setup-")"

# Load library
source "$HERE/lib/load.sh"

# display banner
display_banner

# execute scripts
echo $SCRIPTS | xargs -n 1 bash
