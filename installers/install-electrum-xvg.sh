#!/usr/bin/env bash
GITHUB_URL="https://github.com/vergecurrency/electrum-xvg"
echo " **** Instalador de cartera electrum para moneda XVG ***"
echo " - Instalando dependencias ..."
sudo apt-get -f -y install git pyqt4-dev-tools python-pip python-dev python-slowaes
sudo pip install pyasn1 pyasn1-modules pbkdf2 tlslite qrcode

mkdir -p "$HOME/.local/opt/" && cd "$HOME/.local/opt/" || exit 1
git clone "$GITHUB_URL" electrum-xvg && cd electrum-xvg || exit 1
pyrcc4 "icons.qrc" -o "gui/qt/icons_rc.py"
sudo python setup.py install
chmod +x "./electrum-xvg"

./electrum-xvg
