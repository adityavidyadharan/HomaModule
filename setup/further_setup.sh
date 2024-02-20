make
cd util
make

cd ..
sudo insmod homa.ko 

sudo apt install python3-pip
python -m pip install matplotlib

cd cloudlab
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile
cp gdbinit ~/.gdbinit

source ~/.bashrc

cd ..