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
    eval local -a dependencies=$1

    # echo -n "Installing dependencies..."
    for dependence in "${dependencies[@]}"
    do
        echo "---"
        echo "Installing $dependence ..."

        # ($SU $INSTALL $dependence > /dev/null 2>&1 & wait$!)
        ($SU $INSTALL $dependence & wait $!)

        if [ "$?" = "0" ];then
            echo "$(ink "blue" "success")"
        else
            echo "$(ink "red" "faiure")"
        fi
    done
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

        rm $logfile
        return $status

    else
        echo "$failed"

        (cat $logfile & wait $!)
        rm $logfile

        exit 1
    fi
}
