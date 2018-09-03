#!/bin/bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs
cd SafariBooks-Downloader
npm install
npm install -g
