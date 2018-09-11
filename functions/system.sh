#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 03-09-2018 02:24
# ================================

declare -x load_distro_info
declare -x pyvrun3

function pyvrun3() {
  local venv_path
  venv_path="$HOME/.local/venv/v3"
  
  if [ -d "$venv_path" ] && source "$venv_path/bin/activate";then
    python "$@"
    if declare -F | grep -q deactivate;then
      deactivate
    else
      echo " - [ERROR] Virtual environment could not be deactivated."
      return 1
    fi
  else
    echo " - [ERROR] virtual environment $venv_path could not be loaded."
    return 1
  fi
}

function load_distro_info() {
  if [ -f "/etc/os-release" ]; then
    source /etc/os-release
    export OS_LIKE_CODENAME="${UBUNTU_CODENAME}"
    export OS_CODENAME="${VERSION_CODENAME}"
    export OS_ID="${ID}"
    export OS_NAME="${NAME}"
    export OS_VERSION_ID="${VERSION_ID}"
    export OS_ID_LIKE="${ID_LIKE}"
  elif [ -f "/etc /etc/lsb-release" ]; then 
    source /etc/lsb-release
  fi
}
