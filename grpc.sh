#sudo swapoff -a
#sudo dd if=/dev/zero of=/swapfile bs=1M count=2048

#sudo mkswap /swapfile
#sudo swapon /swapfile
#sudo reboot


sudo apt-get install autoconf libtool

git clone -b v1.37.x https://github.com/grpc/grpc
cd grpc
git submodule update --init


export MY_INSTALL_DIR=$CMAKE_PREFIX_PATH
mkdir -p $MY_INSTALL_DIR
mkdir -p cmake/build
cd cmake/build

~/RealSense/cmake-3.20.1/bin/cmake -DBUILD_SHARED_LIBS=ON -DgRPC_INSTALL=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR ../..
make -j4
make install

#mkdir -p third_party/abseil-cpp/cmake/build
#pushd third_party/abseil-cpp/cmake/build
#cmake -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
#      -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \
#      ../..
#make -j
#make install

#export LD_LIBRARY_PATH=~/.local/lib:$LD_LIBRARY_PATH

# check if cpp helloworld example compiles
cd ../../grpc/examplescpp/helloworld
mkdir -p cmake/build
cd cmake/build
cmake -DCMAKE_PREFIX_PATH=$MY_INSTALL_DIR ../..
make -j

# change ~/.bashrc
