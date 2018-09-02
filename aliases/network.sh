#!/usr/bin/env bash
# Modified:

# nmcli
#alias ifaces='nmcli -t device status | cut -d":" -f1 && echo'

alias curl='curl -m 30 '
alias ifconfig='/sbin/ifconfig'
# donwload acceleators
alias axel='axel -a '
alias aria2='aria2c --summary-interval=0 --truncate-console-readout true '

# firewall
alias ufw-test='sudo ufw --dry-run '

# youtube-dl
alias youtube-dl='youtube-dl --download-archive "$XDG_CONFIG_DIR/video-downloader/videos.list"  '
alias youtube-axel='youtube-dl --download-archive "$XDG_CONFIG_DIR/video-downloader/videos.list" --external-downloader axel --external-downloader-args "-n 15 -a -k"'
alias ydl='youtube-dl '
alias youtube-to-mp3='youtube-dl --extract-audio --audio-format mp3 --audio-quality '

# web apps
alias hitbtc-app='chromium --app=https://hitbtc.com/sso/signin'
alias binance-app='chromium --app=https://www.binance.com/'
alias cryptopia-app='chromium --app=https://www.cryptopia.co.nz/Login'
# alias myip='echo  "$(echo -n " - [INFO] Requesting ... " >&2)|$(curl -s myip.dtdns.com || echo "FAIL" 1>&2)|)"'
alias netfind='sudo netdiscover -r 192.168.1.0/24'
