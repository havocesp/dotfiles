#!/usr/bin/env bash

# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Created:  28-08-2018
# Modfied: 28-27-2018 19:23
# License: MIT
# ===============================

function svg2png() {
	if [ $# -eq 1 ] && [ -f "$1" ]; then
		if echo "$1" | grep -q 'svg'; then
			inkscape -z -e "$1" "$1.png" # convert -size 128x128 "$1"
		fi
	elif [ $# -eq 3 ]; then
		test -f "$1" && inkscape -z -e "$1" -w "${2}" -h "${3}"
	else
		echo " - Usage: svg2png <file> [width] [height]"
		return 16
	fi
}

function sgml2pdf() {
	[ $# -eq 1 ] && sgmltools -b pdf "$1" || return 16
}

# --- MAN PAGES ---
function has_manpage() {
	man -w "${1:-FAIL}" &>/dev/null
}

function man2pdf() {
	if has_manpage "$1"; then
		local output_file
		output_file="$1.pdf"
		echo "${2:-doc}" | grep -q pdf && output_file="$2"
		zcat "$(man -w "$1")" | groff -mandoc -Tpdf >"$output_file"
	else
		echo " - ERROR: not man pages for command $1."
		return 16
	fi
}

function man2html() {
	if has_manpage "$1"; then
		zcat "$(man -w "$1")" | groff -mandoc -Thtml >"$1.html"
	else
		echo " - ERROR: not man pages for command $1."
		return 16
	fi
}

function mangui() {
	if has_manpage "$1" &>/dev/null; then
		man2pdf "$1" && mimeopen "$1.pdf" && rm "$1.pdf"
	elif [ $# -eq 0 ]; then
		if which "zenity" &>/dev/null; then
			local cmd
			cmd="$(zenity --entry --title="Man Page" --text="Enter command name:")"
			cmd="$(basename "${cmd:-ERROR}")"
			cmd_path="$(which "$cmd")"
			if [ -n "$cmd_path" ] && [ -e "$cmd_path" ] && [ -x "$cmd_path" ]; then
				man2pdf "$cmd" && mimeopen "$cmd.pdf" && rm "$cmd.pdf"
			fi
		else
			echo " - Usage: mangui <command>"
		fi
	fi
}
