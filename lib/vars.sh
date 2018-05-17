#!/bin/bash

# PATH
ROOTDIR="$HOME/setupscripts"
LIBDIR="$ROOTDIR/lib"
BINDIR="$ROOTDIR/bin"

SRCDIR="$HOME/local/src"

# ALIAS
SU="sudo"
DOWNLOAD="wget -q --no-check-certificate"
EXTRACT="tar xf"

# SCRIPT
SPINNER="${BINDIR}/spinner"

# CHECK
if has "apt-get"; then

    INSTALL="apt-get -qq install -y"

elif has "yum"; then

    INSTALL="yum -q -y install"

elif has "homebrew"; then

    INSTALL="homebrew"

fi
