#!/bin/bash

# lower returns a copy of the string with all letters mapped to their lower case.
# shellcheck disable=SC2120
lower() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

# upper returns a copy of the string with all letters mapped to their upper case.
# shellcheck disable=SC2120
upper() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:lower:]" "[:upper:]"
}

# is_exists returns true if executable $1 exists in $PATH
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# has is wrapper function
has() {
    is_exists "$@"
}

# die returns exit code error and echo error message
die() {
    e_error "$1" 1>&2
    exit "${2:-1}"
}

# is_git_repo returns true if cwd is in git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
    return $?
}

# findstr returns 0 if found string
# $1 - string
# $2 - string you want to find
findstr() {
    echo "$1" | grep "$2" > /dev/null 2>&1
    return $?
}

# download is downloading a file from URL
# $1 - option: '-p' - display progressbar, '-np' - don't display progressbar
# $2 - a url
download() {
    local option="$1"
    local url="$2"
    local filename=$(basename "$url")
    local status=

    echo -n "Downloading $url..."

    case "${option}" in
        '-p')
            curl -# -L -o "${SRCDIR}/${filename}" "$url"
            status=$?
            ;;
        '-np')
            curl -s -L -o "${SRCDIR}/${filename}" "$url"
            status=$?
            ;;
    esac

    echo "$(ink "green" " done")"
    return $status
}

# archive_detect returns archive file extension
# $1 - an archive file name
archive_detect() {
    local file="$1"

    if findstr "$file" "tar.gz";then
        echo "tar.gz"
        return 0

    elif findstr "$file" "zip";then
        echo "zip"
        return 0

    else
        return 1
    fi
}

# extract is extracting the archive file
# $1 - an archive file
extract() {
    local status=
    local filepath="$1"
    local filename="$(basename "$filepath")"
    local archive_type="$(archive_detect "$filepath")"

    echo -n "Extracting $filename..."

    case "${archive_type}" in
        "tar.gz")
            tar xf "$filepath" -P -C "$SRCDIR"
            status=$?
            ;;

        "zip")
            unzip -d "$SRCDIR" -qq  "$filepath"
            status=$?
            ;;
    esac

    echo "$(ink "green" " done")"
    return $status
}

# display_banner print a banner
display_banner() {
    echo "              __                                _       __      "
    echo "   ________  / /___  ______     _______________(_)___  / /______"
    echo "  / ___/ _ \/ __/ / / / __ \   / ___/ ___/ ___/ / __ \/ __/ ___/"
    echo " (__  )  __/ /_/ /_/ / /_/ /  (__  ) /__/ /  / / /_/ / /_(__  ) "
    echo "/____/\___/\__/\__,_/ .___/  /____/\___/_/  /_/ .___/\__/____/  "
    echo "                   /_/                       /_/                "
    echo ""
    echo "        Copyright (c) 2018 Alice1017 All Reserved.              "
    return 0
}

# display_banner_msg print banner and message with centering
# $1 - message
display_banner_msg() {
    local msg="$1"
    local msg_length="$(echo "$msg" | wc -c)"
    local max_length=65
    local ljust_length=$(expr $(expr $max_length - $msg_length) / 2)
    local ljust_space=""

    for index in $(seq 1 $ljust_length);do
        ljust_space+=" "
    done

    echo ""
    echo " ************************************************************** "
    echo "${ljust_space}${msg}"
    echo " ************************************************************** "
    return 0
}
