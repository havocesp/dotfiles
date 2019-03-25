#!/bin/bash

APT_FILE_PATH="/etc/apt/sources.list.d/syncthing.list"
APT_KEY_URL="https://syncthing.net/release-key.txt"
APT_REPO_INFO="deb https://apt.syncthing.net/ syncthing stable"

function installer() {
    (apt-get -q2 update && apt-get -q2 -y install "$@") || return 1
}

[[ "$UID" != "0" ]] && echo "[ERROR] root level needed ..." && exit 1

# check for necessary packages and install them if missing
installer "apt-transport-https" "curl" "tee"

# Add the release PGP keys:
curl -s "$APT_KEY_URL" | apt-key add -

# Add the "stable" channel to your APT sources:
echo "$APT_REPO_INFO"  | tee "$APT_FILE_PATH"

# Update and install syncthing:
installer "synthing"
