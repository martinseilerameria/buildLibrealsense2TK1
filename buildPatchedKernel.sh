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

# Is librealsense on the device?

if [ ! -d "$LIBREALSENSE_DIRECTORY" ] ; then
   echo "The librealsense repository directory is not available"
   read -p "Would you like to git clone librealsense? (y/n) " answer
   case ${answer:0:1} in
     y|Y )
         # clone librealsense
         cd ${HOME}
         echo "${green}Cloning librealsense${reset}"
         git clone https://github.com/IntelRealSense/librealsense.git
         cd librealsense
         # Checkout version the last tested version of librealsense
         git checkout $LIBREALSENSE_VERSION
     ;;
     * )
         echo "Kernel patch and build not started"   
         exit 1
     ;;
   esac
fi

# Is the version of librealsense current enough?
cd $LIBREALSENSE_DIRECTORY
VERSION_TAG=$(git tag -l $LIBREALSENSE_VERSION)
if [ ! $VERSION_TAG  ] ; then
   echo ""
  tput setaf 1
  echo "==== librealsense Version Mismatch! ============="
  tput sgr0
  echo ""
  echo "The installed version of librealsense is not current enough for these scripts."
  echo "This script needs librealsense tag version: "$LIBREALSENSE_VERSION "but it is not available."
  echo "This script uses patches from librealsense on the kernel source."
  echo "Please upgrade librealsense before attempting to patch and build the kernel again."
  echo ""
  exit 1
fi

KERNEL_BUILD_DIR="/usr/src/kernel"

# Get the kernel sources; does not open up editor on .config file
echo "${green}Getting Kernel sources${reset}"
./getKernelSources.sh
echo "${green}Patching and configuring kernel${reset}"
sudo ./scripts/patchKernel.sh
sudo ./scripts/configureKernel.sh

cd $KERNEL_BUILD_DIR
# Make the new Image and build the modules
echo "${green}Building Kernel and Modules${reset}"
./makeKernel.sh
# Now copy over the built image
./copyImage.sh
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

