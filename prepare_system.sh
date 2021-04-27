#!/bin/bash

sudo apt-get update
sudp apt-get upgrade
sudo apt-get dist-upgrade

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
cd ${HOME}
CMAKE_VERSION=3.20.1
wget https://github.com/Kitware/CMake/archive/v${CMAKE_VERSION}.zip
# Make it easier to work with a shorter name
unzip v${CMAKE_VERSION}.zip
mv CMake-${CMAKE_VERSION} CMake
rm v${CMAKE_VERSION}.zip
cd CMake
time ./bootstrap
# Get the number of CPUs 
NUM_CPU=$(nproc)
time make -j$(($NUM_CPU - 1))
if [ $? -eq 0 ] ; then
  echo "CMake make successful"
else
  # Try to make again; Sometimes there are issues with the build
  # because of lack of resources or concurrency issues
  echo "CMake did not build " >&2
  echo "Retrying ... "
  # Single thread this time
  time make 
  if [ $? -eq 0 ] ; then
    echo "CMake make successful"
  else
    # Try to make again
    echo "CMake did not successfully build" >&2
    echo "Please fix issues and retry build"
    exit 1
  fi
fi

sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile none swap sw 0 0" | tee -a /etc/fstab > /dev/null
sudo reboot
