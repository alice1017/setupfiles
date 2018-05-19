#!/bin/bash

# Define variables & functions
URL="https://github.com/alice1017/setupscripts/archive/master.zip"
FILENAME="$(basename "${URL}")"
DIRNAME="setupscripts-master"

is_exists() {
    type "$1" >/dev/null 2>&1
    return $?
}

download() {
    local url=$1
    local filename="$(basename $url)"
    local status=

    echo -n "Downloading ${URL} ..."

    (curl -s -L -o $filename $url & wait $!) || {
        echo " failed"
        echo "init.sh:download: Download was faile Download was failedd" 1>&2
        exit 1
    }
    status=$?

    echo " done"
    return $status
}

detect_pm() {
    if is_exists "apt-get"; then
        echo "apt-get -qq install -y"

    elif is_exists "yum"; then
        echo "yum -q -y install"

    elif is_exists "homebrew"; then
        echo "homebrew"

    fi
}

extract() {
    local filename=$1
    local status=
    local pm="$(detect_pm)"

    if ! is_exists "unzip";then
        echo -n "Installing unzip ..."
        (sudo $pm unzip > /dev/null 2>&1 & wait $!) || {
            echo " failed"
            echo "init.sh:extract: unzip installation was failed" 1>&2
            exit 1
        }
        echo " done"
    fi

    echo -n "Extracting ${filename} ..."

    (unzip $filename > /dev/null 2>&1 & wait $!) || {
        echo " failed"
        echo "init.sh:extract: extract was failed" 1>&2
        exit 1
    }
    status=$?

    echo " done"
    return $status
}

clean() {
    echo -n "Cleaning temporary files ..."
    (rm $FILENAME && rm -rf $DIRNAME & wait $!)
    echo "done"
}

# Download zip
download "$URL"

# Extract zip
extract "$FILENAME"

# Move dir
cd $DIRNAME

# Execute scripts
bash setup-zsh.sh

# Move pre dir
cd ..

# Clean temporary files
clean
