# Build latest librealsense2 and grpc on Toradex Apalis TK1

This is for
* NVIDIA Jetpack 3.1
* L4T 21.7
* BSP 2.8b6
* Linux Kernel 3.10.40-2.8.6+g2c7a3c3af726


### Flash Toradex Easy Installer

Download and flash Toradex Easy Installer.
https://developer.toradex.com/knowledge-base/load-toradex-easy-installer
https://docs.toradex.com/104851-apalis-tk1-toradexeasyinstaller.zip

Unzip file.
Connect Apalis and host machine via Micro USB cable. 
Shut down Apalis.
Connect Recovery pins.
Start Apalis.
Remove Recovery pins.
Run ./recovery-linux.sh

### Toradex Installer

Install Jetpack 3.1 image

### Prepare system
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

sudo apt-get install git
cd ~
mkdir RealSense
cd RealSense
git clone https://github.com/martinseilerameria/buildLibrealsense2TK1.git
chmod +x  ./buildLibrealsense2TK1/prepare_system.sh
chmod +x  ./buildLibrealsense2TK1/install.sh
./buildLibrealsense2TK1/prepare_system.sh
```
Wait for reboot.

### Install librealsense, OpenCV and gRPC
```
cd ~/RealSense
./buildLibrealsense2TK1/install.sh
```
