#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 24-08-2018 17:30
# ================================

### Variables
declare DOTFILES_DIR
declare FUNCTIONS_DIR ALIASES_DIR

### Functions
declare -x init_dotenv
declare -x not_declared
declare -x declare_safe
declare -x declare_list
declare -x cmdcheck
declare -x cmdrun

DOTFILES_DIR="$HOME/.dotfiles"

FUNCTIONS_DIR="${DOTFILES_DIR}/functions"
ALIASES_DIR="${DOTFILES_DIR}/aliases"

function declare_list() {
    echo -e "$(declare -p)$(declare -F)" | sed 's/declare [xfrFiaA-]*[ ]//g' | grep --color=no -E '^[a-zA-Z]'
}

function cmdrun() {
    if [[ $# -lt 2 ]]; then
        echo " - Usage: cmdrun <message> <command>"
        return 1
    else
        echo -n " - $1 ... "
        if command "$@" &>/dev/null; then
            echo "[DONE]"
        else
            echo "[FAIL]"
            return 1
        fi
    fi
}

# check command availability
function cmdcheck() {
    command -v "${1:-fail}" &>/dev/null
}

# sudo alias for android termux
if cmdcheck tsu;then
    alias sudo="tsu"
fi

# init dof files.
function init_dotenv() {
    local dotfile
    local -i failed
    local -a dot_files

    failed=0

    while read -r dotfile; do
        dot_files+="$dotfile"
        source "$dotfile" || echo " - ERROR: error during aliases file $dotfile import."
    done <<<$(find "$ALIASES_DIR" -name '*.sh')

    while read -r dotfile; do
        dot_files+="$dotfile"
        source "$dotfile" || echo " - ERROR: error function file source $dotfile import."
    done <<<$(find "$FUNCTIONS_DIR" -name '*.sh')

    if [[ "$failed" -gt 0 ]]; then
        local report
        report=" - [$(date +'%d %b %R')] Result:\n\n - ${failed} files has failed during boot process."
        cmdcheck notify-send && notify-send -i error '[DotFiles]' "$report"
        echo -e "$report"
    fi
}

if ! grep -q "init_dotenv" "$HOME/.bashrc";then
	msg=" - Adding 'init_dotenv' function call to '.bashrc'"
	line="source $DOTFILES_DIR/setup.sh\ninit_dotenv"
	cmd=('echo' "-e" "$line" '>>' "$HOME/.bashrc")
	echo "${cmd[@]}"
    cmdrun "$msg" "$cmd"
fi
