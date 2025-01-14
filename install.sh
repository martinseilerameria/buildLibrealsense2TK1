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

sudo apt-get install libxinerama-dev -y
sudo apt-get install libxcursor-dev -y
sudo apt-get install xorg-dev -y
sudo apt-get install libglu1-mesa-dev -y

# make and install
mkdir build 
cd build
~/RealSense/cmake-3.20.1/bin/cmake ../ -DFORCE_LIBUVC=true -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=release

make -j4
sudo make install



# OPENCV

cd ~/RealSense
git clone https://github.com/opencv/opencv.git --branch 4.2.0
cd opencv
mkdir build && cd build
cmake  ..
cmake --build .
sudo make install



# GRPC
cd ~/RealSense
sudo apt-get install autoconf libtool -y

git clone https://github.com/grpc/grpc
cd grpc
git submodule update --init


export MY_INSTALL_DIR=$HOME/.local
mkdir -p $MY_INSTALL_DIR
mkdir -p cmake/build
cd cmake/build

cmake -DBUILD_SHARED_LIBS=ON -DgRPC_INSTALL=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR ../..
make -j4
sudo make install

cd ~/RealSense/grpc/third_party/abseil-cpp/
mkdir -p cmake/build
cd cmake/build
cmake -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE ../..
make -j
sudo make install

# check if cpp helloworld example compiles
cd ~/RealSense/grpc/examples/cpp/helloworld
mkdir -p cmake/build
cd cmake/build
cmake -DCMAKE_PREFIX_PATH=$MY_INSTALL_DIR ../..
make -j
