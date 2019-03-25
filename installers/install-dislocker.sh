#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 31-08-2018 20:18
# ================================

set -e

if [ $UID -ne 0 ]; then
	echo "Are you Root?"
	exit 1
fi

echo "Actualizando lista de paquetes ..."
apt-get -q=2 update
echo "Instalando dependencias ..."
apt-get -q=2 install "gcc" "cmake" "make" "libfuse-dev" "libmbedtls-dev" "ruby-dev"
echo "Descargando dislocker ..."
cd "$HOME/.local"
git clone "https://github.com/Aorimn/dislocker.git"
cd dislocker
cmake .
make
sudo make install
