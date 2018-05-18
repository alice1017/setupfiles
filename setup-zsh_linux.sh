#!/bin/bash

# Load library
source "$HOME/setupscripts/lib/load.sh"

# Display banner
display_banner_msg "Install zsh 5.5.1 from source"

# Define variables
URL="http://www.zsh.org/pub/zsh-5.5.1.tar.gz"
FILE="zsh-5.5.1.tar.gz"
DIR="zsh-5.5.1"
DEPENDENCIES=("libc6" "libcap2" "libtinfo5" "libncursesw5" "libpcre3")

clean() {
    rm "$SRCDIR/$FILE"
    rm -rf "$SRCDIR/zsh-5.5.1"
}

error_msg() {
    if [ $? != 0 ];then
        echo "Error occured!!"
        cat "$logfile"
        clean
        exit 1
    else
        rm "$logfile"
    fi
}

# Install dependics
for dependence in "${DEPENDENCIES[@]}"
do
    $SPINNER "${SU} ${INSTALL} ${dependence}" "" "Installing dependence '${dependence}'"
done

# Download & Extract tarball
$SPINNER "download ${URL}" "" "Downloading ${FILE}"
$SPINNER "extract ${FILE}" "" "Extracting ${FILE}"

# make
cd ${DIR}

local logfile="/tmp/zsh-configure.log"
$SPINNER "./configure > $logfile 2>&1" "" "Configureing before make"
error_msg

local logfile="/tmp/zsh-make-install.log"
$SPINNER "${SU} make install > $logfile 2>&1" "" "Installing"
error_msg

local logfile="/tmp/zsh-make-clean.log"
$SPINNER "make clean > $logfile 2>&1" "" "Cleaning"
error_msg

clean
