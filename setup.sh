#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 24-08-2018 17:30
# ================================
set -Eeo pipefail

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

FUNCS_DIR="${DOTFILES_DIR}/functions"
ALIAS_DIR="${DOTFILES_DIR}/aliases"

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
    command -v "${1:-fail}" >/dev/null
}

# sudo alias for android termux
if cmdcheck tsudo;then
    alias sudo="tsudo"
fi

# init dof files.
function init_dotenv() {
    local dotfile
    local -a dot_files

    dot_files+=($(find "$FUNCS_DIR" -type f -name '*.sh'))
    dot_files+=($(find "$ALIAS_DIR" -type f -name '*.sh'))

    for dotfile in "${dot_files[@]}"; do
        source "$dotfile" || echo " - ERROR: error during $dotfile import."
    done
}

if ! grep -q init_dotenv "$HOME/.bash_aliases";then
    echo -e "source \"$DOTFILES_DIR/setup.sh\"" >> "$HOME/.bash_aliases"
    echo -e 'init_dotenv' >> "$HOME/.bash_aliases"
fi
