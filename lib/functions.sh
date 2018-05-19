#!/bin/bash

error_check() {
    local status="$1"
    local msg="$2"

    if [ "$status" != "0" ];then
        log_fail "$msg"
        exit 1
    fi
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

# make_script_path makes the script path
# $1 - the name of something to install
make_script_path() {
    local name=$1
    local directory="$(dirname $(readlink -f $0))"

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

    echo -n "Installing dependencies..."
    echo "${dependencies[@]}" |  xargs -n 1 $SU $INSTALL
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
