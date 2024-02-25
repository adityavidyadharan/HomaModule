#!/bin/sh

mkdir -p /tmp/kernel

# define urls list

declare -a urls_5_17=(
"https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-headers-5.17.7-051707-generic_5.17.7-051707.202205121146_amd64.deb"
"https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-headers-5.17.7-051707_5.17.7-051707.202205121146_all.deb"
"https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-image-unsigned-5.17.7-051707-generic_5.17.7-051707.202205121146_amd64.deb"
"https://kernel.ubuntu.com/mainline/v5.17.7/amd64/linux-modules-5.17.7-051707-generic_5.17.7-051707.202205121146_amd64.deb"
)

declare -a urls_6_1=(
    "https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-headers-6.1.70-060170-generic_6.1.70-060170.202401011333_amd64.deb"
    "https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-headers-6.1.70-060170_6.1.70-060170.202401011333_all.deb"
    "https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-image-unsigned-6.1.70-060170-generic_6.1.70-060170.202401011333_amd64.deb"
    "https://kernel.ubuntu.com/mainline/v6.1.70/amd64/linux-modules-6.1.70-060170-generic_6.1.70-060170.202401011333_amd64.deb"
)

urls=("${urls_6_1[@]}")

for url in "${urls[@]}"
do
    wget $url -P /tmp/kernel
done

sudo dpkg -i /tmp/kernel/*.deb
sudo update-grub
rm -rf /tmp/kernel
