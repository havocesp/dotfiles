#!/usr/bin/env bash
# Author: Daniel J. Umpierrez
# Modified: 11-08-2018 13:38

declare -x iptables_clean
declare -x iptables_conf
declare -x is_porn
declare -x download
declare -x check_internet
declare -x urlgetter
declare -x check_gateway
declare -x check_iface
declare -x list_ifaces
declare -x get_useragent
declare -x get_external_ip
declare -x get_external_headers

function get_useragent() {
	curl -m 15 -s "https://httpbin.org/user-agent" || curl -m 15 -s "ifconfig.me/ua.json"
}

function get_external_headers() {
	curl -m 15 -s "https://httpbin.org/headers"
}

function get_external_ip() {
	curl -m 15 -s "https://httpbin.org/ip" | grep --color=no -oE '[0-9.]+' || curl -m 15 -s "ifconfig.me"
}

function get_gateway() {
	local gw
	gw="$(route -n | grep -E '^0.0.0.0' | xargs | cut -d' ' -f2)"
	[ -n "$gw" ] && echo "$gw" || return 1
}

function check_internet() {
	wget --timeout=15 "google.com" &>/dev/null || wget --timeout=15 "bing.com" &>/dev/null
}

function check_dns() {
	ping -c 1 -q "8.8.8.8" &>/dev/null
}

function check_gateway() {
	ping -c 1 -q "$(route -n | grep -E '^0.0.0.0' | xargs | cut -d' ' -f2)" &>/dev/null
}

function list_ifaces() {
	tail -n "+$(($(grep -n lo /proc/net/dev | cut -d ':' -f1) + 1))" /proc/net/dev | cut -d':' -f1
}

function check_iface() {
	ip link | grep -qE "${1:-IFACE}"
}

function iptables_conf() {
	# Delete current config
	sudo iptables -F
	sudo iptables -X
	sudo iptables -t nat -F
	sudo iptables -t nat -X
	sudo iptables -t mangle -F
	sudo iptables -t mangle -X
	sudo iptables -P INPUT ACCEPT
	sudo iptables -P FORWARD ACCEPT
	sudo iptables -P OUTPUT ACCEPT
	# Config
	sudo iptables -A INPUT -i lo -j ACCEPT -m comment --comment "Allow all loopback traffic"
	sudo iptables -A INPUT ! -i lo -d 127.0.0.0/8 -j REJECT -m comment --comment "Drop all traffic to 127 that doesn't use lo"
	sudo iptables -A OUTPUT -j ACCEPT -m comment --comment "Accept all outgoing"
	sudo iptables -I INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT -m comment --comment "Allow SSH"
	sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow all incoming on established connections"
	sudo iptables -A INPUT -j REJECT -m comment --comment "Reject all incoming"
	sudo iptables -A FORWARD -j REJECT -m comment --comment "Reject all forwarded"
	sudo bash -c "iptables-save > /etc/network/iptables.rules"
	# iptables -I INPUT -p tcp --dport 80 -j ACCEPT -m comment --comment "Allow HTTP"
	# iptables -I INPUT -p tcp --dport 443 -j ACCEPT -m comment --comment "Allow HTTPS"
}

function urlgetter() {
	for arg in "$@"; do
		echo -n "${arg}" | xargs | grep -oE '(http[s]?|ftp|mailto|ssh|sshfs)://.+\..+'
	done
}

function is_porn() {
	mkdir -p "$HOME/.local/etc"
	[ -f "$HOME/.local/etc/youtube-dl.list" ] || touch "$HOME/.local/etc/youtube-dl.list"
	echo "$1" | is_weburl && echo "$*" | grep -E "xhamster|porn|xvideos"
}

function download() {
	local cmd
	if [ $# -gt 0 ]; then
		cmd="wget"
		which axel && cmd="axel" || which aria2c && cmd="aria2c"

		cmd="wget"

		for url in $(urlgetter "$@"); do
			if ps -aux | grep -q "$cmd"; then
				echo "$url" >>"$HOME/.local/shared/downloads.list"
			else
				axel -o "${XDG_DOWNLOAD_DIR}" "${url}"
			fi
		done
	else

		echo " Usage: $0 [<downloader>] <url> [<url> ...]"
		return 1
	fi
}
