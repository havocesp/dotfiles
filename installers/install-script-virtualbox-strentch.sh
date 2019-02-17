#!/usr/bin/env bash
echo '---------------------------------------------------------'
echo ' === Instaldor de VirtualBox 5.2 para Debian Stretch === '
echo '---------------------------------------------------------'
echo '- Comprobando nivel de privilegios ...'
if [ "$UID" -ne 0 ]
then
	echo ' - [ERROR] se necesitan privilegios root!'
	exit 1
fi
echo '- Configurando fuentes APT ...'
echo 'deb http://download.virtualbox.org/virtualbox/debian stretch contrib' > /etc/apt/sources.list.d/virtualbox.list
echo '- Descargando fichero de firma para el repositorio VirtualBox ...'
curl -s "https://www.virtualbox.org/download/oracle_vbox_2016.asc" -O "oracle_vbox_2016.asc"
echo '- Instalando firma ...'
apt-key add oracle_vbox_2016.asc  &> /dev/null
echo '- Limpiando ficheros temporales ...'
rm "oracle_vbox_2016.asc"
echo '- Actualizando fuentes APT ...'
apt-get -q update
if [ $? -ne 0 ]
then
        echo ' - [ERROR] no se pudo actualizar la lista de paquetes'
        exit 1
fi
echo '- Instalando VirtualBox 5.2 ...'
apt-get -q -y install virtualbox-5.2
if [ $? -ne 0 ]
then
        echo ' - [ERROR] no se pudo instalar VirtualBox 5.2'
        exit 1
fi
echo '- Instalando GuestAdditions ISO ...'
apt-get -q -y install virtualbox
if [ $? -ne 0 ]
then
        echo ' - [ERROR] no se pudo instalar la ISO con las GuestAdditions'
        exit 1
fi
echo '- Instalando VirtualBox Extensions ...'
apt-get -q -y install virtualbox
if [ $? -ne 0 ]
then
        echo ' - [ERROR] no se pudieron instalar las extensiones de virtualbox'
        exit 1
fi
echo '- Realizando limpieza ...'
apt-get -q -y autoremove
if [ $? -ne 0 ]
then
        echo ' - [ERROR] no se pudo realizar autoremove'
        exit 1
fi
apt-get -q -y autoclean
if [ $? -ne 0 ]
then
        echo ' - [ERROR] no se pudo realizar apt autoclean'
        exit 1
fi
echo '- Listo!'
echo '
