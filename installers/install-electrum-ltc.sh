#!/usr/bin/env bash
declare DONWLOAD_URL
declare -a DEB_PACKAGES

DONWLOAD_URL="https://electrum-ltc.org/download/Electrum-LTC-3.1.3.1.tar.gz"
DEB_PACKAGES=("python3-setuptools" "python3-pyqt5" "python3-pip" "python3-dev" "libssl-dev")

echo -e " **** Instalador de cartera electrum para moneda XVG **** \n"
sudo echo -n
echo -n " - Instalando dependencias en formato .deb ... "
if sudo apt-get -y install "${DEB_PACKAGES[@]}";then
    echo "DONE"
else
    echo "FAIL"
    exit 1
fi

echo -n " - Instalando dependencias en desde Pipy ... "
if pip3 install --user scrypt;then
    echo "DONE"
else
    echo "FAIL"
    exit 1
fi

echo -n " - Instalando Electrum LTC ... "
if pip3 install --user "$DONWLOAD_URL";then
    echo "DONE"
else
    echo "FAIL"
    exit 1
fi
