#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 03-09-2018 02:23
# ================================

if [ "$(tset -q)" != 'linux' ]; then
  # XWindow clipboard aliases
  # -------------------------------
  # Selection
  # -------------------------------
  alias selection_get_select='xsel'
  alias selection_del='xsel -c'
  # -------------------------------
  # Clipboard
  # -------------------------------
  alias clip_paste='xsel -b -o '
  alias clip_copy='xsel -b -i '
  alias clip_append='xsel -b -a '
  alias clip_reset='xsel -b -c '
fi

alias clear-format='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'
alias isort='python3 -m isort -d '

alias lcase=' tr [:upper:] [:lower:]'
alias ucase=' tr [:lower:] [:upper:]'
