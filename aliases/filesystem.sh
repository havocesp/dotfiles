#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 01-09-2018 00:21
# ================================

alias exist='test -e '
alias is_file='test -f '
alias is_dir='test -d '
alias is_readable='test -r '
alias is_writable='test -w '
alias is_mine='test -O '
alias is_link='test -L '
alias sshfs='sshfs -o cache=yes -o kernel_cache -o compression=no -o large_read '
alias abspath='realpath '
alias jdupes='jdupes -1'
