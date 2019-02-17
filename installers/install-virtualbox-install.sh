#!/usr/bin/env bash

declare REPO_URL
declare KEY_URL
declare VBOX_SOURCE_FILE
# declare APT_SOURCES_LINE
declare -a packages

if [ $UID -ne 0 ]; then
	echo " - [ERROR] Please, run this script with root privileges."
	exit 20
fi

packages=('virtualbox' 'virtualbox-ext-pack' 'virtualbox-guest-additions-iso' 'virtualbox-dkms' 'virtualbox-qt')

REPO_URL="http://download.virtualbox.org/virtualbox/debian"
KEY_URL='https://www.virtualbox.org/download/oracle_vbox_2016.asc'
VBOX_SOURCE_FILE="/etc/apt/sources.list.d/virtualbox.list"

function get_supported_distros() {
	curl -s "$REPO_URL/dists" | grep -oE --color=no '"[a-z]{4,}' | tr -d '"' | xargs
}

function select_distro_dialog() {
	select distro in $(get_supported_distros); do
		echo "deb $REPO_URL $distro contrib"
		break
	done
}

echo -n " - Creating $VBOX_SOURCE_FILE ... "
if echo "$(select_distro_dialog) > $VBOX_SOURCE_FILE"; then
	echo '[DONE]'
else
	echo '[FAIL]'
fi

echo -n " - Downloading VirtualBox repo sign key ... "
if wget -q "$KEY_URL" -O- | apt-key add -; then
	echo '[DONE]'
else
	echo '[FAIL]'
fi

echo -n " - Updating local packages cache ... "
if apt-get -qq update; then
	echo '[DONE]'
else
	echo '[FAIL]'
fi

echo -n " - Downloading and installing VirtualBox from repository ... "
if apt-get -y install "${packages[@]}"; then
	echo '[DONE]'
else
	echo '[FAIL]'
fi

# case "$distro" in
# Latest)
# 	build=lastSuccessful
# 	break
# 	;;
# Successful)
# 	build=lastSuccessful
# 	break
# 	;;
# Stable)
# 	build=lastSuccessful
# 	break
# 	;;
# Pick*)
# 	read -p "Enter a number from 1 to 10000: " number
# 	break
# 	;;
# esac
