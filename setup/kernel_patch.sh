#!/bin/sh

mkdir -p /tmp/kernel

wget -P /tmp/kernel https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-headers-6.1.70-060170-generic_6.1.70-060170.202401011333_amd64.deb
wget -P /tmp/kernel https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-headers-6.1.70-060170_6.1.70-060170.202401011333_all.deb
wget -P /tmp/kernel https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-image-unsigned-6.1.70-060170-generic_6.1.70-060170.202401011333_amd64.deb
wget -P /tmp/kernel https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-modules-6.1.70-060170-generic_6.1.70-060170.202401011333_amd64.deb


sudo dpkg -i /tmp/kernel/*.deb
sudo update-grub
rm -rf /tmp/kernel
