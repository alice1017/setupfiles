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

error_msg() {
    if [ $? != 0 ];then
        echo ""
        echo "Error occured!!"
        cat "$logfile"
        clean
        exit 1
    else
        rm "$logfile"
    fi
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
    local success="$(ink "blue" " success")"
    local status=

    echo -n "$start_msg"

    ($1 & wait $!)
    status=$?

    echo "$success"
    return $status
}

logfile="/tmp/zsh-configure.log"
execute_cmd "./configure > "$logfile" 2>&1" "./configure ..."
error_msg

logfile="/tmp/zsh-make-install.log"
execute_cmd "sudo make install > "$logfile" 2>&1" "sudo make install ..."
error_msg

logfile="/tmp/zsh-make-clean.log"
execute_cmd "make clean > "$logfile" 2>&1" "make clean ..."
error_msg

clean
