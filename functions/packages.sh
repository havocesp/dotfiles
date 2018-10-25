#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 23-08-2018 17:02
# ================================

declare -x get_python_dirs
declare -x get_module_dirs
declare -x get_class_module
declare -x get_installed_list
declare -x get_most_common
declare -x get_pip_installed
declare -x is_installed
declare -x is_installable
declare -x get_pip3_installed
declare -x get_pip3_outdated
declare -x get_pip_outdated
declare -x is_pip_installable
declare -x is_pip_installed
declare -x is_pip3_installed
declare -x is_pip3_installable
declare -x aptcs
declare -x pip_info

function pip_info() {
	local pip_cmd
	pip_cmd="pip"
  if test $# -eq 2 && echo -en "pip" | grep -q; then
    echo -n # TODO
  fi
	if [ $# -eq 1 ] && which pip3 >/dev/null; then
		local temp_dir
		temp_dir="$(mktemp -d -p /tmp)"
		eval "${pip_cmd}${ver} install --download ${temp_dir} -v $1"
	else
		return 16
	fi
}

function get_most_common() {
	echo -en "$@" | sort | uniq -c | sort -rn | head -n1 | xargs | cut -d" " -f2
}

function get_python_dirs() {
	local pydir
	# echo "$@" "/usr/local/lib" "/usr/lib" "${HOME}/.local/lib"
	for pydir in "$@" "/usr/local/lib" "/usr/lib" "$HOME/.local/lib"; do
		find "${pydir}" -maxdepth 1 -type d -name 'python*' -readable -print
	done | sort -u
}


function get_python_dirs() {
	local pydir
	# echo "$@" "/usr/local/lib" "/usr/lib" "${HOME}/.local/lib"
	for pydir in "$@" "/usr/local/lib" "/usr/lib" "$HOME/.local/lib"; do
		find "${pydir}" -maxdepth 1 -type d -name 'python*' -readable -print
	done | sort -u
}

function get_module_dirs() {
	local pydir
	if [ $# -gt 0 ]; then
		for pydir in $(get_python_dirs "${@:2}"); do
			if [ -d "${pydir}/dist-packages" ]; then
				test -d "${pydir}/dist-packages/$1" && echo "${pydir}/dist-packages/$1"
				test -f "${pydir}/dist-packages/$1.py" && echo "${pydir}/dist-packages/$1.py"
			fi
		done | sort -u
	else
		return 16
	fi
}

# function get_class_module() {
# 
# 	if [ $# -gt 0 ]; then
# 		local pydir result filter
# 		local -a modules
# 		filter="$(echo -n '(from[a-zA-Z0-9_ ]+)?(import[ ]+)('"${1}"')')"
# 
# 		for pydir in $(get_python_dirs "${@:2}"); do
# 			result="$(grep -REo "$filter" "${pydir}" 2>/dev/null | cut -f1 -d':' | sed 's|.*lib/python.*/dist-packages/||g' | cut -f1 -d'/')"
# 			# echo "$pydir: $result"
# 			[ -n "$result" ] && modules+="$result"
# 		done
# 
# 		if [ "${#modules[@]}" -gt 0 ]; then
# 			result="$(get_most_common "${modules[@]}")"
# 			if [ -n "$result" ]; then
# 				echo "$result"
# 				return 0
# 			else
# 				return 1
# 			fi
# 		else
# 			return 1
# 		fi
# 	else
# 		return 16
# 	fi
# 
# }

# function pyimporter() {
# 	local pyfile mod
# 	if [ $# -ge 1 ]; then
# 		for pyfile in "${@}"; do
# 			if [ -f "${pyfile}" ] && [ -r "${pyfile}" ]; then
# 				mod="$(grep -oE '^(import|from)[ ]+[a-zA-Z0-9_\.]+' "${pyfile}" | cut -d' ' -f2 | grep -v '__')"
# 				if [ -n "$mod" ]; then
# 
# 					is_pip_installed "$mod" || test -n "$(is_pip_installable "$mod")" && pip install --user "$(is_pip_installable "$mod")"
# 					is_pip3_installed "$mod" || test -n "$(is_pip3_installable "$mod")" && pip3 install --user "$(is_pip3_installable "$mod")"
# 
# 				else
# 
# 					return 1
# 				fi
# 			fi
# 		done
# 	else
# 		return 16
# 	fi
# }

# === PIP RELATED ===

function pip_ensure_installed() {
	if [ $# -eq 1 ]; then
		get_pip_installed | grep -q "$1"
	else
		return 16
	fi
}

function is_pip3_installed() {
	if [ $# -eq 1 ]; then
		get_pip3_installed | grep -q "$1"
	else
		return 16
	fi
}

# function is_pip3_installable() {
# 	if [ $# -eq 1 ]; then
# 		pip3 search "$1" | cut -d' ' -f1 | sort | grep "^$1" | head -n1
# 	else
# 		return 16
# 	fi
# }

function get_pip_installed() {
	pip list --format=freeze | cut -d'=' -f1
}

function get_pip3_installed() {
	pip3 list --format=freeze | cut -d'=' -f1
}
function get_pip_outdated() {
	pip list --format=freeze --outdated | cut -d'=' -f1
}

function get_pip3_outdated() {
	pip3 list --format=freeze --outdated | cut -d'=' -f1
}

# === APT RELATED ===

function apt_list_installed() {
	dpkg-query -l | grep ^ii | cut -d' ' -f3
}

function apt_ensure_installed() {
	get_installed_list | grep -q "${1:-FAIL}" || return 1
}

function is_installable() {
	[ $# -eq 1 ] && apt-cache pkgnames | sort | grep -q "$1" || return 1
}

function aptcs() {
	apt-cache search "$*" | grep -vE '^lib|^node|^php|^ruby|^golang|^font|^xfont' | sort
}
