#!/bin/bash

IFACE="/etc/network/interface"
GRUB="/etc/default/grub"

set -e
[  $UID -ne 0 ] || echo "[ERROR] Root needed."
echo " - Installing xen packages ..."
apt-get -f -q=2 install "xen-linux-system-amd64" "bridge-utils"
[ -f /etc/grub.d/08_linux_xen ] &&  dpkg-divert --divert /etc/grub.d/08_linux_xen --rename /etc/grub.d/20_linux_xen && update-grub
# dpkg-divert --rename --remove /etc/grub.d/20_linux_xen
echo " - Configuring networks interfaces ..."
[ -f "$IFACE" ]  && mv "$IFACE" "$IFACE.bak"

cd "$(dirname $IFACE)"

echo "auto lo" > $IFACE
echo "iface lo inet loopback" >> $IFACE
echo "iface eth0 inte manual" >> $IFACE
echo "auto xenbr0" >> $IFACE
echo "iface xenbr0 inet dhcp" >> $IFACE
echo "   bridge_ports eth0" >> $IFACE

cd "$(dirname $GRUB)"
echo "- Configurando Grub ..."

echo "GRUB_CMDLINE_XEN=\"dom0_mem=1024M,max:1024M\"" >> $GRUB

echo "dom0_max_vcpus=1 dom0_vcpus_pin" >> $GRUB
update-grub
#/etc/xen/xend-config.sxp
