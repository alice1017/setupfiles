#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Display banner
display_banner_msg "Install zsh 5.5.1 from source"

# Define variables
URL="http://www.zsh.org/pub/zsh-5.5.1.tar.gz"
FILE="zsh-5.5.1.tar.gz"
DIR="zsh-5.5.1"
DEPENDENCIES=( \
    "libc6" "libcap2" "libtinfo5" \
    "libncursesw5" "libncursesw5-dev" \
    "libncurses5" "libncurses5-dev" \
    "libpcre3"\
)

clean() {
    rm "$SRCDIR/$FILE"
    rm -rf "$SRCDIR/zsh-5.5.1"
}

# Install dependics
install_dependencies "$(echo ${DEPENDENCIES[@]})"

# Download & Extract tarball
download -np $URL &&  extract "${SRCDIR}/${FILE}"

# make
cd "${SRCDIR}/${DIR}"

execute_cmd() {
    local cmd=$1
    local start_msg=$2
    local logfile=$3
    local success="$(ink "blue" " success")"
    local fialure="$(ink "red" " failed")"
    local status=

    echo "$cmd"
    echo -n "$start_msg"

    ($cmd > $logfile 2>&1 & wait $!)
    status=$?

    if [ "$status" = "0" ];then
        echo "$success"
        return $status

    else
        echo "$failed"

        cat $logfile
        rm $logfile
        clean
        exit 1
    fi
}

execute_cmd "./configure" "./configure ..." "/tmp/zsh-configure.log"
execute_cmd "sudo make install" "sudo make install ..." "/tmp/zsh-make-install.log"
execute_cmd "make clean" "make clean ..." "/tmp/zsh-make-clean.log"

clean
