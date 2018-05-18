#!/bin/bash
# =====================================================
# This program downloaded from following URL.
# https://github.com/b4b4r07/dotfiles/blob/master/etc/install
# copyright (c) b4b4r07 all rights reserved.
# -----------------------------------------------------
# I'm editing and using this script partly.
# =====================================================

# PLATFORM is the environment variable that
# retrieves the name of the running platform
export PLATFORM

ostype() {
    # shellcheck disable=SC2119
    uname | lower
}

# os_detect export the PLATFORM variable as you see fit
os_detect() {
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  PLATFORM='linux'   ;;
        *'darwin'*) PLATFORM='mac'     ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *)          PLATFORM='unknown' ;;
    esac
}

# is_mac returns true if running OS is Macintosh
is_mac() {
    os_detect
    if [ "$PLATFORM" = "mac" ]; then
        return 0
    else
        return 1
    fi
}

# is_linux returns true if running OS is GNU/Linux
is_linux() {
    os_detect
    if [ "$PLATFORM" = "linux" ]; then
        return 0
    else
        return 1
    fi
}

# is_bsd returns true if running OS is FreeBSD
is_bsd() {
    os_detect
    if [ "$PLATFORM" = "bsd" ]; then
        return 0
    else
        return 1
    fi
}

# is_unknown returns true if running OS is unknown
is_unknown() {
    os_detect
    if [ "$PLATFORM" = "unknown" ]; then
        return 0
    else
        return 1
    fi
}

# get_os returns OS name of the platform that is running
get_os() {
    local os
    for os in mac linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}

ink() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <color> <text>"
        echo "Colors:"
        echo "  black, white, red, green, yellow, blue, purple, cyan, gray"
        return 1
    fi

    local open="\033["
    local close="${open}0m"
    local black="0;30m"
    local red="1;31m"
    local green="1;32m"
    local yellow="1;33m"
    local blue="1;34m"
    local purple="1;35m"
    local cyan="1;36m"
    local gray="0;37m"
    local white="$close"

    local text="$1"
    local color="$close"

    if [ "$#" -eq 2 ]; then
        text="$2"
        case "$1" in
            black | red | green | yellow | blue | purple | cyan | gray | white)
            eval color="\$$1"
            ;;
        esac
    fi

    printf "${open}${color}${text}${close}"
}

logging() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <fmt> <msg>"
        echo "Formatting Options:"
        echo "  INFO, ERROR, WARN, INFO, SUCCESS"
        return 1
    fi

    local color=
    local text="$2"
    local flag=

    case "$1" in
        INFO)
            color=white
            flag="   [ INFO ] "
            ;;
        WARN)
            color=green
            flag="   [ WARN ] "
            ;;
        ERROR)
            color=red
            flag="  [ ERROR ] "
            ;;
        SUCCESS)
            color=blue
            flag="[ SUCCESS ] "
            ;;
        *)
            text="$1"
            flag="        [ ] "
    esac

    ink "$color" "$flag"

    if [ "$1" = "ERROR" ] || [ "$1" == "SUCCESS" ]; then
        ink "$color" "$text"
    else
        printf "$text"
    fi

    echo ""
}

log_pass() {
    logging SUCCESS "$1"
}

log_fail() {
    logging ERROR "$1" 1>&2
}

log_warn() {
    logging WARN "$1"
}

log_info() {
    logging INFO "$1"
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
