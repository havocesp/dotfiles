#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 31-08-2018 20:13
# ================================

# if [ $UID -ne 0 ]; then
# 	echo " - [ERROR] Please, run this script with root privileges."
# 	exit 20
# fi
echo " - ProtonVPN Installer - "

declare URL
URL='https://raw.githubusercontent.com/ProtonVPN/protonvpn-cli/master/protonvpn-cli.sh'

echo " - [INFO] Installing dependences ..."
if which lxqt-sudo &>/dev/null; then
	lxqt-sudo bash -c 'apt-get -qq update || apt-get -qq -y install wget python dialog openvpn' || exit 1
else
	sudo -H bash -c 'apt-get -qq update || sudo apt-get -qq -y install wget python dialog openvpn' || exit 1
fi

mkdir -p "$HOME/.local/opt"

echo " - [INFO] Downloading install script ... "
wget -q -O "$HOME/.local/opt/protonvpn-cli.sh" "$URL" || exit 1

echo " - [INFO] Installing protonvpn ..."

if test -f "$HOME/.local/opt/protonvpn-cli.sh"; then
	chmod +x "$HOME/.local/opt/protonvpn-cli.sh"
	ln -sf "$HOME/.local/opt/protonvpn-cli.sh" "$HOME/.local/bin/protonvpn-cli"
fi
