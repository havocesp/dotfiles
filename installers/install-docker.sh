#!/bin/bash

# Docker - Software Store used to deploy applications easily

# install dependecies
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common ||  (echo " - [ERROR] No se pudo descargar e instalar las dependecias necesarias para la instalación de Docker." && exit 1)

# adding key for packages sign cheking
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - || (echo " - [ERROR] No se pudo descargar e instalar la firma de comprobación de paquetes para Docker." && exit 1)

# setting repo config
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" || (echo " - [ERROR] Fallo al editar /etc/apt/source.list" && exit 1)

# repo update & docker install
sudo apt-get update && sudo apt-get install docker-ce || (echo " - [ERROR] No se pudo descargar e instalar Docker." && exit 1)

sudo systemctl enable docker || (echo " - [ERROR] Configurar docker para iniciarse durante el arranque del sistema." && exit 1)

read -p "¿Desea configurar Docker para que pueda ser usado por el usuario (whoami))? (s/n): " resp

if [ -n "$resp" ] && [ "$resp" == "s" ];then
    sudo groupadd docker
    sudo usermod -aG docker "$(whoami)"
fi

# just a test
#docker run hello-world || (echo " - [ERROR] Fallo al ejecutar el test de comprobación de Docker." && exit 1)



