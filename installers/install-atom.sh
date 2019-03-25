#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 01-09-2018 05:04
# ================================

declare MSG_CLEANING
declare MSG_DOWNLOADING
declare MSG_INSTALLING
declare ATOM_URL
declare su_cmd

MSG_DOWNLOADING=" Descargando paquete desde atom.io ..."
MSG_INSTALLING=" Instalando paquete ... "
MSG_CLEANING=" Limpiando ..."

su_cmd="sudo"

if which lxsudo &>/dev/null; then
	su_cmd="lxsudo"
fi

function progress() {
	zenity --display $DISPLAY --progress --pulsate --text="${1:-Work in progress}" --title="Descargando ..." --auto-kill --auto-close
}

ATOM_URL="https://atom.io/download/deb"

tmp="$(tempfile -p 'atom-' -d /tmp -s '.deb')"
trap "{ rm -f "$tmp"; }" SIGQUIT SIGTERM EXIT

echo -n " - $MSG_DOWNLOADING"
wget "$ATOM_URL" -O "$tmp" &>/dev/null | progress "$MSG_DOWNLOADING" && echo " DONE" || echo " ERROR"

echo -n " - $MSG_INSTALLING"
eval "$su_cmd" dpkg -i "$tmp" >/dev/null

echo -n " - $MSG_CLEANING"
rm "$tmp" && echo "DONE" || echo "ERROR"
