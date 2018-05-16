#!/bin/bash

# Load library
source $HOME/setupfiles/lib/load.sh

# Define variables
URL="http://www.zsh.org/pub/zsh-5.5.1.tar.gz"
FILE="zsh-5.5.1.tar.gz"
DIR="zsh-5.5.1"
DEPENDENCIES=("libc6" "libcap2" "libtinfo5" "libncursesw5" "libpcre3")

# Install dependics
for dependence in "${DEPENDENCIES[@]}"
do
    $SPINNER "${SU} ${INSTALL} ${dependence}" "" "Installing dependence '${dependence}'"
done

# Download & Extract tarball
$SPINNER "${DOWNLOAD} -P ${SRCDIR} ${URL}" "" "Downloading ${FILE}"
$SPINNER "$EXTRACT ${FILE}" "" "Extracting ${FILE}"

# make
echo `pwd`
echo "cd ${DIR}"
echo "./configure && make && ${SU} make install && make clean"


# clean
rm $SRCDIR/$FILE
rm -rf "$SRCDIR/zsh-5.5.1"
