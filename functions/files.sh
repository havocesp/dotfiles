#!/usr/bin/env bash

# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 28-08-2018 22:02
# ================================

declare -x mdp
declare -x mdcd
declare -x newdirs

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
	if [ $# -gt 0 ]; then
		mkdir -p "$@"
	else
		echo ' - ERROR: invalid num of args.'
		return 16
	fi
}

function mdcd() {
	if [ $# -ge 1 ]; then
		mkdir -p "$1" && cd "$1" || return 1
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
