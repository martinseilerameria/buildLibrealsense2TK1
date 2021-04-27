#!/bin/bash


# do before
# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get dist-upgrade

# sudo apt-get install git
# cd ~
# mkdir RealSense
# cd RealSense
# git clone https://github.com/martinseilerameria/buildLibrealsense2TK1.git
# chmod +x  ./buildLibrealsense2TK1/prepare_system.sh
# ./buildLibrealsense2TK1/prepare_system.sh

# update gcc
sudo apt remove gcc -y
sudo apt purge gcc -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt-get install gcc-7 g++-7 -y
sudo ln -s /usr/bin/gcc-7 /usr/bin/gcc
sudo ln -s /usr/bin/g++-7 /usr/bin/g++
sudo ln -s /usr/bin/gcc-7 /usr/bin/cc
sudo ln -s /usr/bin/g++-7 /usr/bin/c++

# install cmake
sudo apt-get install libssl-dev -y
wget https://github.com/Kitware/CMake/releases/download/v3.20.1/cmake-3.20.1.tar.gz
tar xf cmake-3.20.1.tar.gz
cd cmake-3.20.1
./configure && make
sudo make install

# swap file
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile none swap sw 0 0" | tee -a /etc/fstab > /dev/null
sudo reboot
