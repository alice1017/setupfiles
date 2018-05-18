#!/bin/bash

# PATH
ROOTDIR="$(dirname $(readlink -f $0))"
LIBDIR="$ROOTDIR/lib"
BINDIR="$ROOTDIR/bin"

SRCDIR="$HOME/local/src"

# ALIAS
SU="sudo"

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
