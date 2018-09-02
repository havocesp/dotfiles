#!/usr/bin/env bash
# Modfied: 14-07-2018 20:12
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

# graphical sudo interface
alias gksudo='lxqt-sudo '
alias gksu='lxqt-sudo '
