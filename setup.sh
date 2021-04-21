echo "Update system"
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade

echo "Install git"
sudo apt-get intall git

mkdir RealSense
cd RealSense
echo "Clone librealsense repo"
git clone https://github.com/IntelRealSense/librealsense.git
echo "Install dep"
sudo apt-get install libxinerama-dev
sudo apt-get install libxcursor-dev
sudo apt-get install libgtk-3-dev

echo "Build kernel"
cd buildLibrealsense2TK1
./buildPatchedKernel.sh

echo "Upgrade gcc"
sudo apt remove gcc
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt-get install gcc-7 g++-7 -y
sudo ln -s /usr/bin/gcc-7 /usr/bin/gcc
sudo ln -s /usr/bin/g++-7 /usr/bin/g++
sudo ln -s /usr/bin/gcc-7 /usr/bin/cc
sudo ln -s /usr/bin/g++-7 /usr/bin/c++

echo "Add Swap"

sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudomkswap /swapfile
sudo swapon /swapfile
sudo nano /etc/fstab

echo " Add /swapfile none swap sw 0 0 to /etc/fstab"
echo "Reboot!"
