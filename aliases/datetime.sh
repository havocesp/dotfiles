#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 23-08-2018 17:01
# ================================

alias epoch='date +%s'

alias hms='date +%r'
alias hm='date +%R'

alias ymd='date +%F'
alias ymdhms='date +%F %r'
alias ymdhm='date +%F %R'

alias dmy='date +%D'
alias dmyhms='date +%D %r'
alias dmyhm='date +%D %R'

alias localdate='dmy'
alias localtime='hms'
alias localdatetime='dmyhms'
alias datetime='ymdhms'

alias epoch2secs="grep --color=no -oE '15[0-9]{8}'"

if which xsel > /dev/null && grep -q xterm <<<"$(tset -q)" && [[ -n "$DISPLAY" ]]
then
    alias epoch2secs="grep --color=no -oE '15[0-9]{8}'"
    alias xsel2epoch="xsel -b -o | grep --color=no -oE '15[0-9]{8}' || xsel -o | grep --color=no -oE '15[0-9]{8}' || date +%s"
    alias epoch2hms="date -d @$(xsel -b -o | grep --color=no -oE '15[0-9]{8}' || xsel -o | grep --color=no -oE '15[0-9]{8}' || date +%s) +%X"
    alias epoch2ymd_hms="date -d @$(xsel -b -o | grep --color=no -oE '15[0-9]{8}' || xsel -o | grep --color=no -oE '15[0-9]{8}' || date +%s) +'%F %X'"
    alias epoch2ymd_hm="date -d @$(xsel -b -o | grep --color=no -oE '15[0-9]{8}' || xsel -o | grep --color=no -oE '15[0-9]{8}' || date +%s) +'%F %R'"
    alias epoch2locale="date -d @$(xsel -b -o | grep --color=no -oE '15[0-9]{8}' || xsel -o | grep --color=no -oE '15[0-9]{8}' || date +%s) +'%D %r'"
    alias epoch2d_b_hms="date -d @$(xsel -b -o | grep --color=no -oE '15[0-9]{8}' || xsel -o | grep --color=no -oE '15[0-9]{8}' || date +%s) +'%d %b %r'"
    alias epoch2d_b_hm="date -d @$(xsel -b -o | grep --color=no -oE '15[0-9]{8}' || xsel -o | grep --color=no -oE '15[0-9]{8}' || date +%s) +'%d %b %R'"
fi
