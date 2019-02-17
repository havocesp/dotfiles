#!/usr/bin/env bash
if [ $UID -ne 0 ];then
  echo "Root needed."
  exit 1
fi
echo "Instalador de dotnet de Microsoft para compatibilidad con C#"
# dependencias
apt update && apt-get install curl libunwind8 gettext apt-transport-https
echo "Descargando clave."
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo "Agregando repositorio para Debian en APT (sources.list)"
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/dotnetdev.list'
echo
echo "Instalando  ..."
apt update && apt-get install dotnet-sdk-2.0.0
echo "Dotnet instalado."
