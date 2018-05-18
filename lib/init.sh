#!/bin/bash

# Initialize directory
if [ ! -e "${SRCDIR}" ];then
    mkdir -p "$SRCDIR"
fi

# Display Banner
display_banner
