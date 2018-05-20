#!/bin/bash

display_banner

# Initialize directory
if [ ! -e "${SRCDIR}" ];then
    mkdir -p "$SRCDIR"
fi
