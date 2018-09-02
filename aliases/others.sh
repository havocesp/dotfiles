#!/usr/bin/env bash

# files, dirs, filesystems, and related

# "ls" aliases

alias ls-script='ls -Q '
alias lsR='ls -R '
alias ls-revesed='ls -r '
# alias ls-by-ext='ls -X '
# alias ls-by-mdate'ls -X '
alias ls-by-name='ls -u '
alias ls-sort='ls -N '
alias ls-by-size='ls -S '
alias ls-ignore='ls -I '
alias lsh='ls -h '
alias lo='ls -o '
alias ls-sec='ls -Z '
alias ll='ls -Al '
alias la='ls -A '
alias ls-ctx='ls -Z '
alias ls='ls --color=auto --block-size=K -N -q '

# alias aptu='sudo bash -c "apt-get update && apt-get -f -y full-upgrade || dpkg --configure -a && apt-get -y autoremove && apt-get autoclean"'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias dfh='df -h '
alias duh='du -h '
alias du1='du --max-depth=1 '
alias du1h='du --max-depth=1 -h '
alias sshfs='sshfs -o cache=yes -o kernel_cache -o large_read -o compression=no '
alias ta_info='python3 -c "from talib import *;import sys;help(globals().get(sys.argv[1].upper()))"'
alias sudo='sudo -H'
alias gksudo='lxsudo -H '

alias how='howdoi -a '
alias how3='howdoi -n3 -a '
alias how5='howdoi -n5 -a '
alias how10='howdoi -n10 -a '
alias how15='howdoi -n15 -a '
# alias howdoi_10a='howdoi -n10 -a '
