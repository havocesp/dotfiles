#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 03-09-2018 02:24
# ================================

if [ "$(tset -q)" != "linux" ]; then
    # --- zenity ---
    alias zenity='zenity --display ":0" '
    alias zen='zenity  '
    alias zen-progress='zenity --progress --auto-close --auto-kill '
    alias zen-pulsate='zenity --progress --pulsate --auto-close --auto-kill '
    alias zen-info='zenity --info --ellipsize --title="INFO" --text='
    alias zen-error='zenity --error --ellipsize --title="ERROR" --text='
    alias zen-warn='zenity --warning --ellipsize --title="WARNING" --text='
    alias zen-pw='zenity --password --title="Password" '
    # --- nofify ---
    alias notify='notify-send '
    alias notify-info='no   tify-send -i info "INFO" '
    alias notify-error='notify-send -i error "ERROR" '
fi