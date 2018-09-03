#!/bin/bash

url="http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz"
tmpdir="$HOME/.local/share"

echo 
echo "Python TA-Lib installer."
echo
if [ $UID -ne 0 ];then

echo " - Checking for wget command."
if which wget > /dev/null;then
    echo " - Checking if destination directory exists."
    if [ -d "$tmpdir" ];then
        cd "$tmpdir"
        if [ $? -ne 0  ];then
            echo "ERROR when changing to directory $HOME/.local/share"
            exit 1
        fi
    else
        echo " - Creating destination directory."
        mkdir -p "$tmpdir"
        if [ $? -ne 0 ];then
            echo "ERROR when creating $HOME/.local/share directory."
            exit 1
        fi
    fi
    echo " - Downloading source code."
    wget "$url" > /dev/null
    if [ $? -ne 0 ];then
        echo "ERROR during TA-Lib source code download from $url"
        exit 1
    fi
    echo " - Installing .deb dependencies."
    sudo apt-get update > /dev/null
    sudo apt-get -y install build-essential python3-pip python3-dev python-stsci.distutils
    if [ $? -ne 0 ];then
        echo "ERROR: while installing dependencies packages python3-pip python3-dev python-stsci.distutils."
        exit 1
    fi
    echo " - Unpacking source code."
    tar -xzf "ta-lib-0.4.0-src.tar.gz" > /dev/null
    if [ $? -ne 0 ];then
        echo "ERROR: while unpacking tar file ta-lib-0.4.0-src.tar.gz."
        exit 1
    fi
    cd ta-lib 
    echo " - Compiling."
    ./configure --prefix=/usr > /dev/null
    if [ $? -ne 0 ];then
        echo "ERROR: while running 'configure' file."
        exit 1
    fi
    make > /dev/null
    if [ $? -ne 0 ];then
        echo "ERROR: while running 'make'."
        exit 1
    fi
    echo " - Installing TA-Lib."
    sudo make install > /dev/null
    if [ $? -ne 0 ];then
        echo "ERROR: while running 'make install'."
        exit 1
    fi
    echo 
    echo "Python TA-Lib has been installed correctly."
    echo
fi