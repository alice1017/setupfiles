#!/bin/bash

# make_script_path makes the script path
# $1 - the name of something to install
make_script_path() {
    local name=$1

    if [ "$(uname)" = "Darwin" ];then
        local directory="$(dirname $(bin/greadlink -f $0))"
    else
        local directory="$(dirname $(readlink -f $0))"
    fi

    # if $PLATFORM is not exist, exec 'os_detect'
    if [ -z "$PLATFORM" ];then
        os_detect
    fi

    # make script name
    script="$(printf "setup-%s_%s.sh" "$name" "$PLATFORM")"
    echo "${directory}/${script}"
    return $?
}

# exec_script execute script by bash.
# $1 - the script path
exec_script() {
    local script_path=$1

    # exec script
    if ! is_bsd || is_unknown; then
        (bash "${script_path}" & wait $!)
        return $?
    fi
}

# install_dependencies installs dependence packages
# $1 - A list of dependence packages
install_dependencies() {
    local dependencies=$1
    local code=

    __install() {
        local dependence=$1
        ($SU $INSTALL $dependence > /dev/null 2>&1 & wait $!)
        return $?
    }

    export -f __install

    echo -n "Installing dependencies..."
    echo "${dependencies[@]}" |  xargs -n 1 -I % bash -c "__install %"
    code=$?
    echo $(ink "blue" " success")

    return $code
}

# execute_cmd executes a command with display message
# $1 - the command string (sample: "cat /etc/hosts")
# $2 - the log file path
execute_cmd() {
    local cmd=$1
    local start_msg="Running ${cmd} ..."
    local logfile=$2
    local success="$(ink "blue" " success")"
    local fialure="$(ink "red" " failed")"
    local status=

    echo -n "$start_msg"

    ($cmd > $logfile 2>&1 & wait $!)
    status=$?

    if [ "$status" = "0" ];then
        echo "$success"
        return $status

    else
        echo "$failed"

        (cat $logfile & wait $!)
        rm $logfile
        clean
        exit 1
    fi
}
