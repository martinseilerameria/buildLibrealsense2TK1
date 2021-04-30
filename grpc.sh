sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=1M count=2048

sudo mkswap /swapfile
sudo swapon /swapfile
sudo reboot


sudo apt-get install autoconf libtool

cd ~/RealSense
git clone -b v1.37.x https://github.com/grpc/grpc
cd grpc
git submodule update --init

mkdir -p cmake/build
cd cmake/build
~/RealSense/cmake-3.20.1/bin/cmake -DBUILD_SHARED_LIBS=ON -DgRPC_INSTALL=ON -DCMAKE_BUILD_TYPE=Release ../..
make -j4
sudo make install
