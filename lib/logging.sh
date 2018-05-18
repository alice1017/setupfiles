#!/bin/bash

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
