#!/bin/bash

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
