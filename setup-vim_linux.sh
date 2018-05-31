#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Define function
is_vim_seven() {
    vim --version | grep 7 > /dev/null 2>&1
    return $?
}

check_status() {
    local status=$1
    local logfile=$2

    if [ "$status" = "0" ];then
        echo "$(ink "blue" " success")"
        return 0
    else
        echo "$(ink "red" " failed")"
        cat "$logfile"
        exit 1
    fi
}

install_vim() {

    local status=

    # apt-get update
    echo -n "Running apt-get update ..."
    (sudo apt-get update --fix-missing > /tmp/apt-update.log 2>&1 & wait $!)
    check_status $? "/tmp/apt-update.log"

    # install
    echo -n "Running sudo apt-get install vim ..."
    (sudo apt-get install -y vim > /tmp/vim-install.log 2>&1 & wait $!)
    check_status $? "/tmp/vim-install.log"

    exit 0
}

# Display banner
display_banner_msg "Install Vim 7 from apt-get"

# check package manager and install
if has "apt-get";then

    # Check already exits version
    if has "vim";then

        if is_vim_seven;then
            log_pass "Vim 7 is already installed"
            exit 0
        else
            install_vim
        fi

    else
        install_vim
    fi

else
    log_fail "Sorry, script don't support other than apt-get"
    exit 1

fi
