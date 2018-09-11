#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 24-08-2018 15:24
# ================================

#if not_declared "msg_debug"; then
declare -x msg_error	
declare -x msg_info
declare -x msg_debug
declare -x msg_warn

declare TIME_FMT
declare DATE_FMT

TIME_FMT='[%H:%M:%S]'
DATE_FMT='[%b-%y]'

function msg_debug() {
	test "${DEBUG:-0}" -eq 1 && echo -e "$*" | ts " - ${DATE_FMT}${TIME_FMT}[$(gray "D")] "
}

function msg_error() {
	echo " - [E][$(date +'%F %r')][E] $*" | ts " - ${DATE_FMT}${TIME_FMT}[$(red "E")]"
	return 1
}

function msg_info() {
	echo " - [I][$(date +'%F %r')][I] $*" | ts " - ${DATE_FMT}${TIME_FMT}[bold $("I")] "
}

function msg_warn() {
	echo " - [WARN][$(date +'%F %r')][W] $*" | ts " - ${DATE_FMT}${TIME_FMT}[$(yellow "W")]"
}
