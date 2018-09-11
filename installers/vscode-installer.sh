#!/usr/bin/env bash

if [ $UID -eq 0 ]
then
    declare KEY_FILENAME
    declare MS_PKG_URL
    declare MS_REPO_URL
    declare DEST_APT_LIST
    
    KEY_FILENAME="microsoft.gpg"

    MS_PKG_URL='https://packages.microsoft.com'
    MS_KEY_URL="$MS_PKG_URL/keys/microsoft.asc"
    MS_REPO_URL="$MS_PKG_URL/repos/vscode"
    DEST_APT_LIST="/etc/apt/sources.list.d/vscode.list"

    echo -n " - Installing dependences ..."
    apt-get -y -qqq install apt-transport-https && echo "DONE" || echo "FAIL"
    
    echo -n " - Installing Microsoft repository key ..."
    curl -s "$MS_KEY_URL" | sudo apt-key add - &> /dev/null && echo "DONE" || echo "FAIL"

    echo -n " - Adding repository list to apt ... "
    sudo sh -c "echo \"deb [arch=amd64] $MS_REPO_URL stable main\" > $DEST_APT_LIST" && echo "DONE" || echo "FAIL"

    echo -n " - Updating local repository cache ... "
    sudo apt-get -y -qqq update &> /dev/null && echo "DONE" || echo "FAIL"
    
    echo -n " - Donwloading and installing vscode ... "
    sudo apt-get -y -qqq install code  &> /dev/null && echo "DONE" || echo "FAIL"
else
    echo " - Plase run this installer as root."
fi
