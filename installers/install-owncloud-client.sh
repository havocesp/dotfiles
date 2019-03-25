#!/bin/bash
echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_9.0_update/ /' > /etc/apt/sources.list.d/owncloud-client.list

apt-get update

apt-get install owncloud-client
