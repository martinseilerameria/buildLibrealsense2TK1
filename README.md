# Build latest librealsense2 and grpc on Toradex Apalis TK1

This is for
* L4T 21.7
* BSP 2.8b6
* Linux Kernel 3.10.40-2.8.6+g2c7a3c3af726


### Flash Toradex Easy Installer

1. [Download](https://docs.toradex.com/104851-apalis-tk1-toradexeasyinstaller.zip) and unzip Toradex Easy Installer.

2. Connect Apalis with host machine via Micro USB cable. 
3. Shut down Apalis.
4. Short two recovery connectors (round, next to green LED).
5. Start Apalis.
6. Unshort recovery connectors.
7. Go to unzipped directory and run ./recovery-linux.sh
8. Toradex Easy Installer will boot

### Toradex Easy Installer

Install Linux 4 Tegra image

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
./buildLibrealsense2TK1/prepare_system.sh
```
Wait for reboot.

### Install librealsense, OpenCV and gRPC
```
cd ~/RealSense
./buildLibrealsense2TK1/install.sh
```
