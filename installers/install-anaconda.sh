#!/usr/bin/env bash
temp_installer_filepath="$HOME/.anaconda.$RANDOM.sh"
echo " - Downloading Anaconda installer ... "
if wget "https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh" -O "$temp_installer_filepath" &> /dev/null
then
  echo " - Installing Anaconda ... "
  chmod +x "$temp_installer_filepath" && "$temp_installer_filepath" && echo "DONE" || echo "FAIL"
fi
