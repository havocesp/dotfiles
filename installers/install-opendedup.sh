#!/usr/bin/env bash
declare -a deps=("fuse" "libfuse2" "ssh" "openssh-server" "jsvc" "libxml2-utils")
declare -i counter=0
declare URL="wget http://opendedup.org/downloads/sdfs-latest.deb"
declare LIMIT_CONF_PATH="/etc/security/limits.conf"

if [ $UID -ne 0 ]
then
    sudo echo || exit 16
else
    echo " - Ejecute este programa como root."
    exit 16
fi

MSG_DOWNLOADING=" Descargando ficheros ..."
MSG_DEPS_INSTALL=" Instalando dependencias ... "
MSG_INSTALLING=" Instalando ... "
MSG_CLEANING=" Limpiando ..."

function progress {
    zenity --display "$DISPLAY" --progress --pulsate --text="$MSG_DOWNLOADING" --title="Descargando ..." --auto-kill --auto-close 2> /dev/null
}


echo "$MSG_DEPS_INSTALL"
for pkg in "${deps[@]}"
do
    sudo apt-get -f -y install "$pkg" &> /dev/null
    let counter++
done | zenity --display "$DISPLAY" --progress --auto-kill --auto-close "$MSG_INSTALLING" text="$MSG_DEPS_INSTALL" 2> /dev/null
# sudo apt-get -f -y install

tmp="$(tempfile -p 'opendedup-'  -d /tmp -s '.deb')"
trap "{ rm -f "$tmp"; }" SIGQUIT SIGTERM EXIT

echo -n " - $MSG_DOWNLOADING"
wget "$URL" -O "$tmp" &> /dev/null |  progress && echo " DONE" || echo " ERROR"

echo -n " - $MSG_INSTALLING"
sudo dpkg -i "$tmp" &> /dev/null || (echo "ERROR" && exit 1)

echo -n " - $MSG_CLEANING"
rm "$tmp" && echo "DONE" || echo "ERROR"



function append {
    if [ $# -eq 2 ]
    then
        test -r "$1" || touch "$2"
        grep -q "$1" "$2"  || echo "$1" >> "$2"
    fi
}
echo -n " - Adding configuration lines to ${LIMIT_CONF_PATH}  ... "
sudo safe_append '* hard nofile 65535' "${LIMIT_CONF_PATH}"
sudo safe_append '* soft nofile 65535' "${LIMIT_CONF_PATH}"
echo "DONE"
