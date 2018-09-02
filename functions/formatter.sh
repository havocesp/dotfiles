#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 11-08-2018 15:00
# ================================

function jsonfmt() {
	local inputs
	[ $# -eq 0 ] && read -r -t1 inputs
	[ -z "$inputs" ] && inputs="$*"
	test -n "$inputs" && echo -e "$inputs" | python3 -m json.tool
}
