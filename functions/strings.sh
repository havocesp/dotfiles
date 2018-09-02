#!/usr/bin/env bash
# ===============================
# Author: Daniel J. Umpierrez
# --------------------------------
# Created:  09-08-2018
# Modified: 28-08-2018 21:37
# License: MIT
# ===============================
declare -x quote

function quote() {
	# add simple or double quotes to all params
	# Use -s to add simple quotes
	local quote_char
	local result

	quote_char='"'

	while (($#)); do
		case "$1" in
		-s) quote_char="'" ;;
		*) result="${result}${quote_char}${1}${quote_char} " ;;
		esac
		shift
	done

	echo -e "${result::-1}"

}
