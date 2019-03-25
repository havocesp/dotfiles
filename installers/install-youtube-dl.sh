#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 21-08-2018 00:24
# ================================
if [ $UID -ne 0 ]; then
	echo " - [ERROR] Please, run this script with root privileges."
	exit 20
else
	curl -L "https://yt-dl.org/downloads/latest/youtube-dl" -o "/usr/local/bin/youtube-dl"
	chmod a+rx "/usr/local/bin/youtube-dl"
fi
