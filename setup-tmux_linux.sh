#!/bin/bash

# Load library
LIBPATH="$(dirname $(readlink -f $0))/lib"
source "$LIBPATH/load.sh"

# Display banner
display_banner_msg "Install tmux 2.5 from source"

# Define variables and function
URL="https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz"
FILE="$(basename ${URL})"
FILEPATH="${SRCDIR}/${FILE}"
DIR="tmux-2.5"
DIRPATH="${SRCDIR}/${DIR}"
DEPENDENCIES=( \
    "automake" "libc6" "libevent-2.0-5" \
    "libtinfo5" "libutempter0" "xsel" \
    "libevent" "libevent-dev" "libevent-devel" \
    "libevent1-dev" "libncurses5-dev" \
)

clean() {
    echo -n "Cleaning temporary files..."

    rm "$FILEPATH"
    rm -rf "$DIRPATH"

    echo "$(ink "green" "done")"
}

# Install dependencies
install_dependencies "(${DEPENDENCIES[*]})"

# Download & Extract tarball
download -np $URL &&  extract "$FILEPATH"

# move source dir
echo "Moved directory from "$(pwd)" to "$(ink "yellow" "$DIRPATH")" "
cd "$DIRPATH"

# execute make commands
execute_cmd "./configure" "/tmp/tmux-configure.log"
execute_cmd "make" "/tmp/tmux-make.log"
execute_cmd "sudo make install" "/tmp/tmux-make-install.log"
execute_cmd "make clean" "/tmp/tmux-make-clean.log"

clean
exit 0
