#!/bin/bash
# Install the Intel Realsense library kernel patches on a NVIDIA Jetson TK1 Development Kit
# Jetson TK1
# Author: Mario Lueder, May 2019

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PATCHFILE="${SCRIPTPATH}/../patches/kernel3.10.40_librealsense_2.21.0.patch"

cd /usr/src/kernel

echo -e "\e[32mApplying realsense kernel patches\e[0m"
patch -p1 < ${PATCHFILE}


