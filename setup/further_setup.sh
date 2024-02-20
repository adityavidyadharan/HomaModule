#!/bin/bash -i

make
cd util
make

cd ..
sudo insmod homa.ko 

sudo apt install python3-pip
python -m pip install matplotlib

cd cloudlab
echo "Copy bashrc"
cp bashrc ~/.bashrc
echo "Copy bash_profile"
cp bash_profile ~/.bash_profile
echo "Copy gdbinit"
cp gdbinit ~/.gdbinit

source ~/.bashrc

cd ..