#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 24-08-2018 17:30
# ================================

### Variables
declare DOTENV_DIR
declare FUNCTIONS_DIR ALIASES_DIR

### Functions
declare -x init_dotenv
declare -x not_declared
declare -x declare_safe
declare -x declare_list
declare -x cmdcheck
declare -x cmdrun

DOTENV_DIR="$HOME/.dotfiles"

FUNCTIONS_DIR="${DOTENV_DIR}/functions"
ALIASES_DIR="${DOTENV_DIR}/aliases"

# function lcase { echo "${*,,}"}
# function ucase { echo "${*~~}" }

function declare_list() {
    echo -e "$(declare -p)$(declare -F)" | sed 's/declare [xfrFiaA-]*[ ]//g' | grep --color=no -E '^[a-zA-Z]'
}

function cmdrun() {
    if [ $# -lt 2 ]; then
        echo " - Usage: cmdrun <message> <command>"
        return 1
    else
        echo -n " - $1 ... "

        if eval "${@:2}" &>/dev/null; then
            echo "[$(green DONE)]"
        else
            echo "[$(green FAIL)]"
            return 1
        fi
    fi
}

# check command availability
function cmdcheck() {
    which "${1:-fail}" >/dev/null
}

# init dof files.
function init_dotenv() {
    local dotfile
    local -i failed
    local -a dot_files

    failed=0

    for dotfile in $ALIASES_DIR/*.sh; do
        dot_files+="$dotfile"
        source "$dotfile" || echo " - ERROR: error during aliases file $dotfile import."
    done

    for dotfile in $FUNCTIONS_DIR/*.sh; do
        dot_files+="$dotfile"
        source "$dotfile" || echo " - ERROR: error function file source $dotfile import."
    done

    if [ "$failed" -gt 0 ]; then
        local report
        report=" - [$(date +'%d %b %R')] Result:\n\n - ${failed} files has failed during boot proccess."
        cmdcheck notify-send && notify-send -i error '[DotFiles]' "$report"
        echo -e "$report"
    fi

}
