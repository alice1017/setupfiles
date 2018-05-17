#!/bin/bash

get_script_name(){
    if ! is_bsd || is_unknown; then
        script_name=$(printf "setup-%s_%s.sh" "$1" "$PLATFORM")
        echo "$script_name"
        return 0

    else
        return 1

    fi
    # bash "$(PWD)/$script_name"
}

