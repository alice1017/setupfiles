#!/bin/bash

# download is downloading a file from URL
# $1 - URL
download() {
    wget -q --no-check-certificate -P "$SRCDIR" "$1"
    return $?
}

# get_script_name makes the shellscript file name from platform
# $1 - the name to setup anything
get_script_name() {
    if ! is_bsd || is_unknown; then
        script_name=$(printf "setup-%s_%s.sh" "$1" "$PLATFORM")
        echo "$script_name"
        return 0

    else
        return 1

    fi
}

