#!/bin/bash

LIBREALSENSE_DIRECTORY=/home/ubuntu/RealSense/librealsense
git clone https://github.com/IntelRealSense/librealsense.git

# add udev rules
cd $LIBREALSENSE_DIRECTORY
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger

# make and install
mkdir build 
cd build
~/CMake/bin/cmake ../ -DFORCE_LIBUVC=true -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=release

NUM_CPU=4
time make -j$(($NUM_CPU))
sudo make install
