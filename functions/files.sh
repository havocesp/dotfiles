#!/usr/bin/env bash

# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 28-08-2018 22:02
# ================================

declare -x mdp
declare -x mdcd
declare -x newdirs
declare -x extract

function win2unix_path() {
    local pipe_data
    read -t 1 pipe_data
    if test -z "$pipe_data";then
        echo "$*" | tr '\' '/'
    else
        echo "$pipe_data" | tr '\' '/'
    fi
}

function mdp() {
	if [[ $# -gt 0 ]]; then
		mkdir -p "$@"
	else
		echo ' - ERROR: invalid num of args.'
		return 16
	fi
}

function mdcd() {
	if [[ $# -ge 1 ]]; then
		mkdir -p ""$1"" && cd ""$1"" || return 1
	else
		msg_error ' - ERROR: invalid num of args.'
		return 16
	fi

}

function newdirs() {
	while (($#)); do
		case "$1" in
		*) [ -d "$1" ] || mkdir -p "${1}" ;;
		esac
		shift
	done
}

# extract all kinds of archived files
function extract() {
if [[ -r "$1" ]]
then
    case "$1" in
        *.tar.bz2)  tar xjf "$1"     ;;
        *.tar.gz)   tar xzf "$1"     ;;
        *.bz2)      bunzip2 "$1"     ;;
        *.rar)      unrar e "$1"     ;;
        *.gz)       gunzip "$1"      ;;
        *.tar)      tar xf "$1"      ;;
        *.tbz2)     tar xjf "$1"     ;;
        *.tgz)      tar xzf "$1"     ;;
        *.zip)      unzip "$1"       ;;
        *.Z)        uncompress "$1"  ;;
        *.7z)       7z x "$1"        ;;
        *)          echo "$1 cannot be extracted via extract()" ;;
     esac
 else
     echo "$1 is not a valid file"
     return 1
 fi
}


function is_executable() {
    local verbose

    if [[ "$1" == '-v' ]] || [[ "$1" == '--verbose' ]];then
        verbose=1
        shift
    fi
    if [[ -x "$1" ]]
    then
        test "${verbose:-0}" -eq 1 && echo -n "$1"
    else
        test "${verbose:-0}" -eq 1 && echo -n "$1"
        return 1
    fi
}
