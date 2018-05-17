#!/bin/bash

# download is downloading a file from URL
# $1 - URL
download() {
    if has "wget";then
        wget -q --no-check-certificate -P "$SRCDIR" "$1"
        return $?

    elif has "curl";then
        local filename="$(basename "$1")"
        curl -s -L -o "${SRCDIR}/${filename}" "$1"
        return $?
    fi
}

# tar_extract is extracting a tar file
# $1 - tarball file name
tar_extract() {
    tar xf "$1" -P -C "$SRCDIR"
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

