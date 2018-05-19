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
    echo ""
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

    display_banner
    echo " ************************************************************** "
    echo "${ljust_space}${msg}"
    echo " ************************************************************** "
    return 0
}
