#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Define functions
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

install_docker_by_apt() {

    local status=

    # Display banner
    display_banner_msg "Install Docker from apt-get"

    # apt-get update
    echo -n "Running apt-get update ..."
    (sudo apt-get update --fix-missing > /tmp/apt-update.log 2>&1 & wait $!)
    check_status $? "/tmp/apt-update.log"

    # install
    echo -n "Running sudo apt-get install docker.io ..."
    (sudo apt-get install -y docker.io > /tmp/docker-install.log 2>&1 & wait $!)
    check_status $? "/tmp/docker-install.log"

    exit 0
}

# check package manager and install
if has "apt-get";then
    install_docker_by_apt
else
    log_fail "Sorry, script don't support other than apt-get"
    exit 1
fi
