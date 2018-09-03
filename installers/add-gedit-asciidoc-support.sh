#!/usr/bin/env bash

declare GTK_SOURCEVIEW3_PATH
declare GTK_SOURCEVIEW2_PATH
declare ASCIIDOC_SINTAX_URL
declare -f global_asciidoc_support_installer

GTK_SOURCEVIEW3_PATH="/usr/share/gtksourceview-3.0/language-specs/"
GTK_SOURCEVIEW2_PATH="/usr/share/gtksourceview-2.0/language-specs/"

ASCIIDOC_SINTAX_URL="https://raw.github.com/edusantana/asciidoc-highlight/master/gedit/asciidoc.lang"

if [ $UID -ne 0 ]
then
    echo " - [ERROR] root permissions required, please try to run this again with sudo command or similar."
    exit 1
fi

function global_asciidoc_support_installer 
{
    if [ -n $1 ] && [ -d "$1" ];then

        cd "GTK_SOURCEVIEW2_PATH"
        
        if [ $? -ne 0 ]
            echo " - [ERROR] Something was wrong in command: cd $1"
            exit 1
        fi
        
        wget "$ASCIIDOC_SINTAX_URL" &> /dev/null
        
        if [ $? -eq 0 ]
        then
            echo " - [DONE]"
            cd -
        else
            echo " - [ERROR] Something was wrong during asciidoc.lang file download from :$ASCIIDOC_SINTAX_URL"
            exit 1
        fi
    fi
}

clear
echo " =========== Gedit Asciidoc support installer ================="
echo "                     ----------------------                    "
echo "                     by Daniel J. Umpierrez                    "
echo "                     ----- 23 Feb 2018 ----                    "
echo " =============================================================="
echo "  Github: https://github.com/havocesp                          "
echo " =============================================================="
echo "                                                               "
echo "  - [INFO] Starting installation ...                           "
echo "  - [INFO] Trying to install ascidoc supoort for GTK2 ...      "
# GtkSourceView version 3
global_asciidoc_support_installer "$GTK_SOURCEVIEW3_PATH"           
echo "  - [INFO] Trying to install ascidoc supoort for GTK3 ...      "
# GtkSourceView version 2
global_asciidoc_support_installer "$GTK_SOURCEVIEW2_PATH"
echo
echo " =============================================================="
echo





