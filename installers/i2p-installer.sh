#!/bin/bash
DEBUG=""
KEY_FILE='i2p-debian-repo.key.asc'
KEY_FILE_URL='https://geti2p.net/_static/i2p-debian-repo.key.asc'
APT_I2P_FILE="/etc/apt/sources.list.d/i2p.list"
APT_I2P_ENTRY="deb http://deb.i2p2.no/ unstable main"
JETTY8_PACKAGE_URL="http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb"
JETTY8_PACKAGE_FILE="libjetty8-java_8.1.16-4_all.deb"
I2P_PACKAGES="libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu i2p i2p-router libjbigi-jni  secure-delete tor"

function checkrun() {
    if [ $# -ne 2 ]; then
        echo "USO: $0 \"Texto previo ...\" \"<comando> <argumentos>\""
        return 1
    else
        echo -n "- $1"

        if [ ${#DEBUG} -eq 0 ];then
            eval "$2 &> /dev/null"
        else
            eval "$2"
        fi
        if [ $? -ne 0 ];then
            echo "[ERROR]" && exit 1
        else
            echo "[OK]"
        fi
    fi
    return 0
}
clear
echo "====== Instalador I2P ======= "
echo " Autor: Daniel J. Umpierrez"
echo " Fecha: 05/12/2017"
echo " Debian Stretch | Sid"
echo "============================="
echo
echo -n "- Comprobando privilegios ... "
if [ $(id -u) -ne 0 ]; then
    echo "[ERROR]"
    echo " Se necesitan permisos root."
    exit 1
fi
echo "[OK]"
echo -n "- Comprobando sistema ... "
(cat /etc/os-release | grep -q Debian) || (echo "[ERROR]" && exit 1)
echo "[OK]"
echo -n "- Eliminando posible $APT_I2P_FILE existentes ... " && rm -f "$APT_I2P_FILE" &> /dev/null || echo "[ERROR]"
echo "[OK]"
checkrun "Creando $APT_I2P_FILE ... " "touch $APT_I2P_FILE"
# Compile the i2p ppa
checkrun "Añadiendo entrada I2P en $APT_I2P_FILE ... " "echo ${APT_I2P_ENTRY} > $APT_I2P_FILE"
[ -f "/tmp/$KEY_FILE" ] && rm /tmp/$KEY_FILE &> /dev/null
checkrun "Obteniendo clave publica de I2P ... " "wget -q $KEY_FILE_URL -O /tmp/$KEY_FILE"
checkrun "Agregando clave publica ... " "apt-key add /tmp/$KEY_FILE"
checkrun "Borrando fichero $KEY_FILE ..." "rm /tmp/$KEY_FILE"
checkrun "Actualizando repositorio local ..." "apt-get -q update"
checkrun "Obteniendo $JETTY8_PACKAGE_FILE desde $JETTY8_PACKAGE_URL ... " "wget -q $JETTY8_PACKAGE_URL"
# apt-get install libservlet3.0-java
checkrun "Instalando $JETTY8_PACKAGE_FILE ... " "dpkg -i $JETTY8_PACKAGE_FILE"

checkrun "Instalando resto de paquetes ... " "apt-get -q install $I2P_PACKAGES"
checkrun "Reparando dependencias ... " "apt-get -q -f install"
checkrun "Instalando claves I2P para apt ... " "apt-get -q install -y i2p-keyring"
checkrun "Instalando I2P ... " "apt-get -q install -y i2p"
checkrun "Eliminando $JETTY8_PACKAGE_FILE ... " "rm $JETTY8_PACKAGE_FILE"
echo
echo "- I2P Instalado con éxito."
echo
echo "- Recuerde: "
echo
echo "  Configurar I2P como servicio: dpkg-reconfigure i2p"
echo "  Iniciar I2P a mano: i2prouter start"
echo "  Iniciar I2P a mano sin Java: i2prouter-nowrapper"
echo "  Iniciar Chromium usando I2P: chromium --proxy-server=http://127.0.0.1:4444"
# Configure and install the .deb
# dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb # Build the deb package
# dpkg -i kali-anonsurf.deb || (apt-get -f install && dpkg -i kali-anonsurf.deb) # this will automatically install the required packages

exit 0
