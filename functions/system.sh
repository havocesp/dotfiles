#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 03-09-2018 02:24
# ================================

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
#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 01-09-2018 00:21
# ================================

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
