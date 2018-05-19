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
# $1 - URL
download() {
    local url="$1"
    local status=
    local filename=$(basename "$1")

    curl -# -L -o "${SRCDIR}/${filename}" "$url"

    status=$?
    error_check "$status" "Download failure."
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
    local archive_type="$(archive_detect "$1")"

    if [ "$archive_type" = "tar.gz" ];then
        tar xf "$1" -P -C "$SRCDIR"

        status=$?
        error_check "$status" "Extract failure."
        return $status

    elif [ "$archive_type" = "zip" ];then
        unzip -d "$SRCDIR" -qq  "$1"

        status=$?
        error_check "$status" "Extract failure."
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
