#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 11-08-2018 13:30
# ================================
declare -x get_video_duration
declare -x get_video_quality
declare -x get_icon_theme
declare -x get_cursor_theme
declare -x get_theme_name
declare -x get_icon_categories

# alias icons-bycat='find /usr/share/icons/gnome/scalable -maxdepth 1 -exec basename "{}" \; && echo  "all"'
# alias icons-byext='find /usr/share/icons/gnome/scalable -maxdepth 1 -exec basename "{}" \;'
# alias icons-bysize='find /usr/share/icons/gnome/scalable -maxdepth 1 -exec basename "{}" \;'
alias icon-sizes='cd /usr/share/icons/gnome && find . -maxdepth 1 -type d -exec basename "{}" \; |sort -n| cut -d "x" -f1 | xargs | sed "s/\. //g"'
alias icons-list='find /usr/share/icons/gnome/scalable -type f | grep svg | sort -u '
alias icons-search='find /usr/share/icons/gnome -type f | sort -u | grep  ico | grep '
# alias icons-categories='cd /usr/share/icons/gnome/scalable && find . -maxdepth 1 -exec basename "{}" \; | xargs | sed "s/\. //g"'

function get_icon_categories() {
	local theme
	theme="$(gsettings get org.gnome.desktop.interface icon-theme | xargs)"
	find "/usr/share/icons/$theme/." -maxdepth 1 -type d -exec basename "{}" \; | grep -Eo '[a-zA-Z0-9 _.-]+$' | xargs
}

function get_icon_theme() {
	gsettings get org.gnome.desktop.interface icon-theme | xargs
}

function get_cursor_theme() {
	gsettings get org.gnome.desktop.interface cursor-theme | xargs
}

function get_theme_name() {
	gsettings get org.gnome.desktop.interface gtk-theme | xargs
}

function get_video_duration() {
	ffmpeg -i "${1}" 2>&1 | grep -E 'Duration' | xargs | grep -Eo '[0-9]{2}:[0-9:]+'
	#statements
}

function get_video_quality() {
	ffmpeg -i "${1}" 2>&1 | grep -E 'Stream.+Video.+' | xargs | grep -Eo '[0-9]+p'
}
