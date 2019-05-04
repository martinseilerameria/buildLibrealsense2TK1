#!/bin/bash
cd /usr/src
wget http://developer.download.nvidia.com/embedded/L4T/r21_Release_v5.0/source/kernel_src.tbz2
tar -xvf kernel_src.tbz2
cd kernel
zcat /proc/config.gz > .config
cp /lib/firmware/tegra_xusb_firmware /usr/src/kernel/firmware/
#make xconfig
