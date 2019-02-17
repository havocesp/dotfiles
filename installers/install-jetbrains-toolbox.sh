#!/usr/bin/env bash
# ================================
# Author: Daniel J. Umpierrez
# --------------------------------
# Modified: 11-09-2018 16:57
# ================================

declare URL
URL="https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-1.11.4269.tar.gz"
make -p "$HOME/.local/opt"
echo " - [INFO] Downloading Jetbrains Toolbox ... "
wget -qO "$HOME/.local/opt/jetbrains-toolbox.tar.gz" "$URL"
# echo " - [INFO] Installing dependences ..."
# apt-get update
# apt-get -y install python-wxgtk3.0 python-twisted python-enchant python-pysocks python-cryptography
echo " - [INFO] Installing JetBrains Toolbox ..."
cd "$HOME/.local/opt" && tar -xzf jetbrains-toolbox.tar.gz && mv jetbrains-toolbox-* jetbrains-toolbox
cd jetbrains-toolbox
nohup ./jetbrains-toolbox &>/dev/null
