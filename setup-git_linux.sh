#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Display banner
display_banner_msg "Install git v2.15.0 from source"

# Define variables and function
URL="https://github.com/git/git/archive/v2.15.0.tar.gz"
FILE="$(basename $URL)"
DIR="git-2.15.0"
DIRPATH="${SRCDIR}/${DIR}"
DEPENDENCIES=( \
    "libc6"  "libcurl3-gnutls"  "libexpat1" "libpcre3" "zlib1g" \
    "libcurl4-openssl-dev" "libexpat1-dev" "perl-modules" \
    "libcurl4-gnutls-dev" "libssl-dev" "gettext" \
    "liberror-perl" "patch" "less" "rsync" "ssh-client"
)

clean() {
    echo -n "Cleaning temporary files..."

    rm "$SRCDIR/$FILE"
    rm -rf "$SRCDIR/$DIR"

    echo "$(ink "green" "done")"
}

# Install dependics
install_dependencies "$(echo ${DEPENDENCIES[@]})"

# Download & Extract tarball
download -np $URL &&  extract "${SRCDIR}/${FILE}"

# move source dir
echo "Moved directory from "$(pwd)" to "$(ink "yellow" "$DIRPATH")" "
cd "$DIRPATH"

# execute make commands
execute_cmd "make configure" "/tmp/git-make-configure.log"
execute_cmd "./configure --prefix=/usr" "/tmp/git-configure.log"
execute_cmd "sudo make install" "/tmp/git-make-install.log"
execute_cmd "make clean" "/tmp/git-make-clean.log"

clean
exit 0
