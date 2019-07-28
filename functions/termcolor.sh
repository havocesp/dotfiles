#!/usr/bin/env bash
# Modified: 10-08-2018 02:42

if [[ "$(tput colors)" -ge 256 ]] 2>/dev/null; then
  tput sgr0

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
    echo -e "$(tput "$1")${*:2}$(tput sgr0)"
  }

  function red() {
      local color

    if [[ "${1:-'fail'}" == "-l" ]]; then
      color=$(eval echo -n "\$L_$(get_caller_name -u)")
    elif [[ "${1:-'fail'}" == "-d" ]]; then
      color=$(eval echo -n "\$D_$(get_caller_name -u)")
    else
      color=$(eval echo -n "\$$(get_caller_name -u)")
    fi
    shift
    colorize "setaf $color" "${*}"
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
