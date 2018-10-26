#!/usr/bin/env bash

# declare -F pip-upgrade &> /dev/null || source "$HOME/.bash_aliases.d/functions.sh"

# package handling

# python pip3

# TODO alias pip3-upgrade='while read pkg;do pip3 install --user -U "$pkg";done <<<$(sudo pip3 freeze | cut -d'=' -f1 | xargs)'
alias pip3s='pip3 search '
alias pip3iu='pip3 install --user '
alias pip3iuu='pip3 install --user -U '

# default pip (usually 2.7 version)
alias pips='pip search '
alias pipiu='pip install --user '
alias pipiuu='pip install --user -U '

# python venv
alias venv_init='source $HOME/.local/venvs/v3/bin/activate'

alias pip-pkgver='pip3 freeze | grep -i '

# apt aliases as pkg
alias pkg-refresh='sudo apt-get update'
alias pkg-update='sudo apt-get update'
alias pkg-find='apt-cache search '
alias pkg-install='sudo apt install '

alias aptcs='apt-cache search '
alias apts='apt search '
# alias aptupgrade='sudo apt-update && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get autoclean'
alias aptshow='apt-cache show '
# alias aptauto='sudo apt autoremove && sudo apt autoclean'
alias apti='sudo apt-get install '
alias aptu='sudo bash -c "apt update && apt-get -f -y full-upgrade && apt-get -y autoremove && apt-get autoclean" || notify-send -i error "System Update" "Something was wrong on package manager update task."'
alias apt-list='apt-cache pkgnames | sort'
# aptitude
# alias aptitudei='sudo aptitude install '
# dpkg
alias dpkg-list-names='dpkg-query --show --showformat="\${Package}\n"'
alias dpkg-list-names-version='dpkg-query --show --showformat="\${Package} \${Version}\n"'
alias dpkgi='dpkg -i '
alias dpkgl='dpkg -l '

# atom package manager
alias apm="apm --color "
