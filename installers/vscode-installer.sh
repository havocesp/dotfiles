#!/usr/bin/env bash

if [ $UID -eq 0 ]
then
    KEY_FILENAME="microsoft.gpg"

    MS_PKG_URL='https://packages.microsoft.com'
    MS_KEY_URL="$MS_PKG_URL/keys/microsoft.asc"
    MS_REPO_URL="$MS_PKG_URL/repos/vscode"
    DEST_APT_LIST="/etc/apt/sources.list.d/vscode.list"


    echo -n " - Installing Microsoft repository key ..."
    curl -s "$MS_KEY_URL" | sudo apt-key add - &> /dev/null
    echo "DONE"

    echo -n " - Adding repository list to apt ... "
    sudo sh -c "echo \"deb [arch=amd64] $MS_REPO_URL stable main\" > $DEST_APT_LIST"
    echo "DONE"
    echo -n " - Updating local repository cache ... "
    sudo apt-get -y update &> /dev/null
    echo "DONE"
    echo -n " - Donwloading and installing vscode ... "
    sudo apt-get -y -qqq install code  &> /dev/null
    echo "DONE"
else
    echo " - Plase run this installer as root."
fi
