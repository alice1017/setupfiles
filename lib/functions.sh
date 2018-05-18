#!/bin/bash

error_check() {
    local status=$1
    local msg=$2

    if [ "$status" != "0" ];then
        log_fail "$msg"
        exit 1
    fi
}

# search_string returns 0 if found string
# $1 - string
# $2 - string you want to find
search_string() {
    echo "$1" | grep "$2" > /dev/null 2>&1
    return $?
}

# download is downloading a file from URL
# $1 - URL
download() {
    local status=
    local filename=

    if has "wget";then

        if search_string "$(wget --version)" "1.17";then
            wget -q --no-check-certificate -P "$SRCDIR" --show-progress "$1"

            status=$?
            error_check status "Download failure."
            return $status

        else
            wget --no-check-certificate -P "$SRCDIR" "$1"

            status=$?
            error_check "Download failure."
            return $status
        fi

    elif has "curl";then

        filename=$(basename "$1")
        curl -# -L -o "${SRCDIR}/${filename}" "$1"

        status=$?
        error_check "Download failure."
        return $status

    fi
}

# archive_detect returns archive file extension
# $1 - an archive file name
archive_detect() {
    local file="$1"

    if search_string "$file" "tar.gz";then
        echo "tar.gz"
        return 0

    elif search_string "$file" "zip";then
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
    local archive_type=

    archive_type="$(archive_detect "$1")"

    if [ "$archive_type" = "tar.gz" ];then
        tar xf "$1" -P -C "$SRCDIR"

        status=$?
        error_check "Extract failure."
        return $status

    elif [ "$archive_type" = "zip" ];then
        unzip -d "$SRCDIR" -qq  "$1"

        status=$?
        error_check "Extract failure."
        return $status
    fi
}

# get_script_name makes the shellscript file name from platform
# $1 - the name to setup anything
get_script_name() {
    if ! is_bsd || is_unknown; then
        script_name=$(printf "setup-%s_%s.sh" "$1" "$PLATFORM")
        echo "$script_name"
        return 0

    else
        return 1

    fi
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
