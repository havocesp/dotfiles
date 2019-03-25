#!/bin/bash
# shellcheck disable=SC1091

echo " *** Cozy Desktop intaller - by Havocesp ***"
echo
if [ UID -ne 0 ]; then
	echo " - [ERROR] Please, run this script with root privileges."
	exit 20
fi
echo " - Obteniendo clave ..."
wget -O - "https://cozy-desktop.cozycloud.cc/cozy-desktop.gpg.key" 2>/dev/null | apt-key add -
echo " - Actualizando sources.list  ..."
echo 'deb [arch=amd64] https://cozy-desktop.cozycloud.cc/debian jessie cozy-desktop' | tee /etc/apt/sources.list.d/cozy.list
echo " - Actualizando lista de paquetes e instalando ..."
apt-get -yq update && apt-get -yq install cozy-desktop-gui
echo " - Cozy instalado con exito."
