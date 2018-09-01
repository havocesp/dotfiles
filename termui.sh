#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 24-08-2018 17:30
# ================================

declare -x cursor_hide
declare -x cursor_up
declare -x clear_line
declare -x to_pos
declare -x get_password
declare -x norm

function cursor_up() {
	tput cuu"${1:-1}" && sleep 0.2
}

function clear_line() {
	cursor_up "${1:-1}" && tput el
}

function to_pos() {
	local CURPOS
	read -sdrR -p $'\E[6n' CURPOS
	# Strip decoration characters '<ESC>['
	CURPOS="${CURPOS#*[}"
	# Return position in "row;col" format
	echo "${CURPOS}" | tr ';' "${1:- }"
}

function norm() {
	echo -en "\033[?12l\033[?25h"
}

function get_password() {
	local password prompt
	prompt="${1:-"Enter Password: "}"
	while IFS= read -p "$prompt" -r -s -n 1 char; do
		if [[ "$char" == $'\0' ]]; then
			break
		fi
		prompt='*'
		password+="$char"
	done
	echo "$password"
}

# function cursor_hide() {
# 	echo -en '\033[?25l'
# }
