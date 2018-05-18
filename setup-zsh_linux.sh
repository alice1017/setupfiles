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

success="$(ink "blue" " success")"
done="$(ink "green" " done")"

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
for dependence in "${DEPENDENCIES[@]}"
do
    $SPINNER "${SU} ${INSTALL} ${dependence}" "" "Installing dependence '${dependence}'"
done

# Download & Extract tarball
$SPINNER "$(download $URL)" "" "Downloading $URL..."
$SPINNER "$(extract "${SRCDIR}/${FILE}")" "" "Extracting $FILE..."

# make
cd "${SRCDIR}/${DIR}"

logfile="/tmp/zsh-configure.log"
$SPINNER "$(./configure > "$logfile" 2>&1)" "" "RUN './configure'..."
error_msg

logfile="/tmp/zsh-make-install.log"
$SPINNER "$(sudo make install > "$logfile" 2>&1)" "" "RUN 'sudo make install'..."
error_msg

logfile="/tmp/zsh-make-clean.log"
$SPINNER "$(make clean > "$logfile" 2>&1)" "" "RUN 'make clean'..."
error_msg

clean
