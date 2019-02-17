#!/bin/bash
#
# Pipelight installer v2 for Debian 7.1 (wheezy)
#
# Supported distributions: Debian
# Supported releases:      7.0, 7.1 (wheezy)
# Supported architectures: amd64, i386
# Supported browsers:      Iceweasel (Firefox), Chromium
#
# Copyright (C) 2013 Jari Jokinen. MIT License.
# URL: https://github.com/jarijokinen/debian-pipelight

repository_url="http://download.opensuse.org/repositories/home:/DarkPlayer:/Pipelight/Debian_7.0/"
repository_key_url="${repository_url}Release.key"
repository_key_name="CAA5DFC8"
silverlight_installer_url="http://silverlight.dlservice.microsoft.com/download/B/3/C/B3CF6815-40B1-4E36-8746-C4A0381AD260/20513.00/runtime/Silverlight.exe"
silverlight_installer_path="/var/lib/wine-browser-installer/wine-silverlight5.1-installer.exe"
pipelight_plugin_path="/usr/lib/pipelight/libpipelight.so"
mozilla_pipelight_plugin_path="/usr/lib/mozilla/plugins/libpipelight.so"
installer_tmp_path="/tmp/pipelight-installer"

sources_list_path="/etc/apt/sources.list.d/pipelight.list"
sources_list_content="deb $repository_url ./"
sources_list_content+="\ndeb http://ftp.debian.org/debian/ wheezy contrib"

# Helpers

bold=`tput bold`
regular=`tput sgr0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`

function formatted_text {
  if [[ -x "/usr/bin/tput" ]]; then
    echo -e "${1}${2}${regular}"
  else
    echo -e "${2}"
  fi
}

function bold   { formatted_text "$bold" "$1"; }
function red    { formatted_text "$red" "$1"; }
function green  { formatted_text "$green" "$1"; }
function yellow { formatted_text "$yellow" "$1"; }
function blue   { formatted_text "$blue" "$1"; }

function error {
  echo "E: $1"
  exit 1
}

# MAIN

[[ $EUID -eq 0 ]]         || error "this script must be run as root."
[[ -x /usr/bin/dpkg ]]    || error "dpkg is missing."
[[ -x /usr/bin/apt-get ]] || error "apt-get is missing."

bold "\nPipelight Installer v2\n"

echo -n "Checking distribution... "
if [[ -f /etc/debian_version ]]; then
  dist="debian"
  green $dist
else
  red "Unknown"
  error "distribution not supported."
fi

echo -n "Checking release... "
release=$(cat /etc/debian_version)
if [[ $release == "7.0" || $release == "7.1" ]]; then
  green $release
else
  red $release
  echo "release not supported."
fi

echo -n "Checking architecture... "
arch=$(dpkg --print-architecture)
if [[ $arch == "amd64" ]]; then
  yellow $arch
  echo -n "Checking foreign architecture... "
  foreign_arch=$(dpkg --print-foreign-architectures | grep i386)
  if [[ $foreign_arch == "i386" ]]; then
    green $foreign_arch
  else
    bold "i386 missing, adding... "
    dpkg --add-architecture i386
    apt-get -qq update
    echo -n "Checking foreign architecture... "
    foreign_arch=$(dpkg --print-foreign-architectures | grep i386)
    if [[ $foreign_arch == "i386" ]]; then
      green $foreign_arch
    else
      error "adding i386 as foreign architecture failed."
    fi
  fi
elif [[ $arch == "i386" ]]; then
  green $arch
else
  red $arch
  error "architecture not supported."
fi

echo -n "Checking temporary directory... "
if [[ -d $installer_tmp_path ]]; then
  green "found"
else
  mkdir -p $installer_tmp_path
  green "created"
fi

echo -n "Checking repository key... "
keycheck=$(apt-key list | grep "$repository_key_name" | wc -l)
if [[ $keycheck == "1" ]]; then
  green "found"
else
  bold "missing, downloading..."
  wget -q "$repository_key_url" -O "$installer_tmp_path/Release.key"
  apt-key add "$installer_tmp_path/Release.key" > /dev/null
  echo -n "Checking repository key... "
  keycheck=$(apt-key list | grep "$repository_key_name" | wc -l)
  if [[ $keycheck == "1" ]]; then
    green "found"
  else
    echo "adding repository key failed."
  fi
fi

echo -n "Checking apt sources... "
if [[ -f $sources_list_path ]]; then
  green "found"
else
  bold "missing, adding... "
  echo -e "$sources_list_content" > $sources_list_path
fi

echo -n "Updating apt sources... "
apt-get -qq update
green "done"

echo -n "Checking Silverlight installer... "
if [[ $(dpkg -s "wine-silverlight5.1-installer" 2> /dev/null) ]]; then
  green "found"
else
  bold "missing, installing..."
  apt-get -qq --no-install-recommends install wine-silverlight5.1-installer \
    > /dev/null
  wget -q $silverlight_installer_url -O $installer_tmp_path/silverlight.exe
  cp $installer_tmp_path/silverlight.exe $silverlight_installer_path
fi

echo -n "Checking Pipelight... "
if [[ $(dpkg -s "pipelight" 2> /dev/null) ]]; then
  green "found"
else
  bold "missing, installing..."
  apt-get --no-install-recommends install pipelight > /dev/null
fi

bold "\nInstallation done!\n"
echo "Go here to test your new setup:"
echo -e "http://bubblemark.com/silverlight2.html\n"

exit 0
