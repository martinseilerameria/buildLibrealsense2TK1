#!/bin/bash
cd ~/RealSense
LIBREALSENSE_DIRECTORY=/home/ubuntu/RealSense/librealsense
git clone https://github.com/IntelRealSense/librealsense.git

# add udev rules
cd librealsense
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger

# dependencies
sudo apt-get install libusb-1.0-0-dev pkg-config -y
sudo apt-get install libglfw3-dev libgtk-3-dev -y

# make and install
mkdir build 
cd build
~/CMake/bin/cmake ../ -DFORCE_LIBUVC=true -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=release

NUM_CPU=4
time make -j$(($NUM_CPU))
sudo make install
