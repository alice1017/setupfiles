#!/bin/bash

# Load library
if [ "$(uname)" = "Darwin" ];then
    LIBPATH="$(dirname $(bin/greadlink -f $0))/lib"
else
    LIBPATH="$(dirname $(readlink -f $0))/lib"
fi

source "$LIBPATH/load.sh"

# make the script name & execute
script_name=$(make_script_path "zsh")
exec_script $script_name

# check exit code
if has "zsh";then

    # change default shell
    echo -n "Changing defualt shell to "$(which zsh)" ..."
    (sudo chsh -s $(which zsh) $(whoami) & wait $!)
    echo "$(ink "green" " done")"

    log_pass "Zsh installation was successful."

else
    log_fail "Zsh installation was failed."
fi


