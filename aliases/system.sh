#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 03-09-2018 02:22
# ================================

alias rsync-test='rsync -n '
alias rm-boost="rsync -a --delete "
# alias ps-cpu='ps aux | sort -nk3'
# alias ps-mem='ps aux | sort -nk4'
alias sulast='sudo !!'
alias watch15='watch -n 15 -d '
alias watch5='watch -n 5 -d '
alias hist='history'
alias histfind="history | grep -iE \"\$(echo -n '.*')\""
alias historic='history | grep -i '
# alias aptu='sudo apt update && sudo apt -f -y full-upgrade && sudo apt -y autoremove && sudo apt autoclean || notify-send -i error "System Update" "Something was wrong on package manager update task."'

if [ "$(tset -q)" != "linux" ]; then
  # graphical sudo interface
  alias gksudo='lxqt-sudo '
  alias gksu='lxqt-sudo '
fi
# system info
# alias os_codename="lsb_release -c | xargs |  grep --color=no -oE '[a-zA-Z0-9_-]+$'"
# alias os_parent_codename="lsb_release -c | xargs |  grep --color=no -oE '[a-zA-Z0-9_-]+$'"
