#!/bin/bash
# Patch the kernel for the Intel Realsense library librealsense on a Jetson TK1 Development Kit
# Copyright (c) 2016-18 Jetsonhacks
# MIT License

CLEANUP=true

LIBREALSENSE_DIRECTORY=/mnt/project-sdcard/projects/librealsense
LIBREALSENSE_VERSION=v2.21.0


function usage
{
    echo "usage: ./buildPatchedKernel.sh [[-n nocleanup ] | [-h]]"
    echo "-n | --nocleanup   Do not remove kernel and module sources after build"
    echo "-h | --help  This message"
}

# Iterate through command line inputs
while [ "$1" != "" ]; do
    case $1 in
        -n | --nocleanup )      CLEANUP=false
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done



INSTALL_DIR=$PWD

# Error out if something goes wrong
set -e

KERNEL_BUILD_DIR="/usr/src/kernel"

# Get the kernel sources; does not open up editor on .config file
echo "${green}Getting Kernel sources${reset}"
./getKernelSources.sh
echo "${green}Patching and configuring kernel${reset}"
sudo ./scripts/patchKernel.sh
sudo ./scripts/configureKernel.sh

# cd $KERNEL_BUILD_DIR
# Make the new Image and build the modules
echo "${green}Building Kernel and Modules${reset}"
./scripts/makeKernel.sh
# Now copy over the built image
./scripts/copyzImage.sh
# Remove buildJetson Kernel scripts
#if [ $CLEANUP == true ]
#then
# echo "Removing Kernel build sources"
# ./removeAllKernelSources.sh
# cd ..
# sudo rm -r $KERNEL_BUILD_DIR
#else
# echo "Kernel sources are in /usr/src"
#fi


echo "Please reboot for changes to take effect"

