#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 31-08-2018 20:14
# ================================

declare URL
URL="https://www.confidantmail.org/download/confidantmail_0.37-1.deb"

if [ UID -ne 0 ]; then
	echo " - [ERROR] Please, run this script with root privileges."
	exit 20
fi

echo " - [INFO] Downloading package ... "
wget -qO "$TEMP/confidantmail.deb" "$URL"
echo " - [INFO] Installing dependences ..."
apt-get update
apt-get -y install python-wxgtk3.0 python-twisted python-enchant python-pysocks python-cryptography
echo " - [INFO] Installing confidantmail ..."

dpkg -i "$TEMP/confidantmail.deb"

xdg-open "https://www.confidantmail.org/acct.php"
