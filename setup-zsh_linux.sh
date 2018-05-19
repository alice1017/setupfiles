#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Display banner
display_banner_msg "Install zsh 5.5.1 from source"

# Define variables and function
URL="http://www.zsh.org/pub/zsh-5.5.1.tar.gz"
FILE="zsh-5.5.1.tar.gz"
DIR="zsh-5.5.1"
DIRPATH="${SRCDIR}/${DIR}"
DEPENDENCIES=( \
    "libc6" "libcap2" "libtinfo5" \
    "libncursesw5" "libncursesw5-dev" \
    "libncurses5" "libncurses5-dev" \
    "libpcre3"\
)

clean() {
    echo -n "Cleaning temporary files..."

    rm "$SRCDIR/$FILE"
    rm -rf "$SRCDIR/zsh-5.5.1"

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
execute_cmd "./configure" "/tmp/zsh-configure.log"
execute_cmd "sudo make install" "/tmp/zsh-make-install.log"
execute_cmd "make clean" "/tmp/zsh-make-clean.log"

clean
exit 0
