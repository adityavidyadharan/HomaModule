#!/bin/sh

mkdir -p /tmp/kernel

wget -P /tmp/kernel/ https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-headers-5.17.7-051707-generic_5.17.7-051707.202205121146_amd64.deb
wget -P /tmp/kernel https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-headers-5.17.7-051707_5.17.7-051707.202205121146_all.deb
wget -P /tmp/kernel https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-image-unsigned-5.17.7-051707-generic_5.17.7-051707.202205121146_amd64.deb
wget -P /tmp/kernel https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-modules-5.17.7-051707-generic_5.17.7-051707.202205121146_amd64.deb

sudo dpkg -i /tmp/kernel/*.deb
sudo update-grub
rm -rf /tmp/kernel
