#!/usr/bin/env bash
# Modified: 10-08-2018 02:42

if [[ "$(tput colors)" -ge 256 ]] 2>/dev/null; then
	tput sgr0

	declare D_RED
	declare L_RED
	declare RED
	declare D_MAGENTA
	declare MAGENTA
	declare L_MAGENTA
	declare CYAN
	declare D_BLUE
	declare BLUE
	declare PURPLE
	declare YELLOW
	declare L_YELLOW
	declare D_YELLOW
	declare ORANGE
	declare L_ORANGE
	declare D_ORANGE
	declare GREEN
	declare L_GREEN
	declare D_GREEN
	declare BLACK
	declare WHITE
	declare GRAY
	declare D_GRAY
	# export OFF RESET BOLD

	D_RED=1
	RED=9
	L_RED=196
	CYAN=14
	D_MAGENTA=93
	MAGENTA=128
	L_MAGENTA=201
	D_BLUE=21
	BLUE=32
	YELLOW=190
	D_YELLOW=184
	L_YELLOW=226
	ORANGE=208
	D_ORANGE=166
	L_ORANGE=214
	GREEN=10
	D_GREEN=3
	L_GREEN=82
	PURPLE=141
	WHITE=256
	GRAY=246
	D_GRAY=238
	BLACK=232
	# alias BOLD="tput bold"
	# alias RESET="tput sgr0"
	# alias OFF="tput sgr0"

	declare -x get_caller_name
	declare -x colorize
	declare -x red
	declare -x l_red
	declare -x d_red
	declare -x green
	declare -x d_green
	declare -x l_green
	declare -x bold

	function get_caller_name() {
        local func_name
        func_name="${FUNCNAME[-1]}"

		if [ "${1:-'fail'}" == '-u' ];then
            echo -e "${func_name~~}"
        elif [ "${1:-'fail'}" == '-l' ];then
            echo -e "${func_name^^}"
        else
            echo -e "${func_name}"
        fi
	}

	function colorize() {
		# aliases -x  | grep -q OFF || return 1
		# echo "$(tput setaf $(eval \$$1))${*:1}$(tput sgr0)"
		echo -e "$(tput $1)${*:2}$(tput sgr0)"
		# printf "%s%s%s\n" "$(tput setaf $1)" "${*:1}" "$(tput sgr0)
	}

	function red() {
		local color
		local -a args
		args=("${@}")
		if [ "${1:-'fail'}" == "-l" ]; then
			color=$(eval echo -n "\$L_$(get_caller_name -u)")
            args=("${args[@:1]}")
		elif [ "${1:-'fail'}" == "-d" ]; then
			color=$(eval echo -n "\$D_$(get_caller_name -u)")
            args=("${args[@:1]}")
		else
			color=$(eval echo -n "\$$(get_caller_name -u)")
		fi
		colorize "setaf $color" "${args[*]}"
	}

	function l_red() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

	function d_red() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

	function green() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}
	function d_green() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}
	function l_green() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

	function bold() {
		colorize "bold" "$*"
	}

	function yellow() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}
	function d_yellow() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}
	function l_yellow() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

	function purple() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}
	function magenta() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

	function cyan() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

	function blue() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

	function gray() {
		colorize "setaf $(eval echo -n "\$$(get_caller_name -u)")" "$*"
	}

fi
