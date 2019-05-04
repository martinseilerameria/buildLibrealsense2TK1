#!/bin/bash
# Configure the kernel for the Intel Realsense library on a NVIDIA Jetson TK1 Development Kit
# Copyright (c) 2016-18 Jetsonhacks
# 
# Jetson TK1
#
# Edit:
#    Mario Lueder: Adapted from TX to TK1 Development Kit
#    Mario Lueder: Added Firmware

echo "Configuring Kernel for librealsense"

cd /usr/src/kernel
echo "Current working directory: "$PWD
KERNEL_VERSION=$(uname -r)
# For L4T 21.5 the kernel is 3.10.40; everything after that is the local version
# This removes the suffix
LOCAL_VERSION=${KERNEL_VERSION#$"3.10.40"}

# == Industrial I/O support
# IIO_BUFFER - Enable buffer support within IIO
# IIO_TRIGGERED_BUFFER -
# HID_SENSOR_IIO_COMMON - Common modules for all HID Sensor IIO drivers
# HID_SENSOR_IIO_TRIGGER - Common module (trigger) for all HID Sensor IIO drivers)
# HID_SENSOR_HUB - HID Sensors framework support
# == Devices
# HID_SENSOR_ACCEL_3D - HID Accelerometers 3D (NEW)
# HID_SENSOR_GYRO_3D - HID Gyroscope 3D (NEW)


bash scripts/config --file .config \
        --set-str EXTRA_FIRMWARE "tegra_xusb_firmware" \
        --set-str EXTRA_FIRMWARE_DIR "firmware" \
	--set-str LOCALVERSION $LOCAL_VERSION \
	--enable IIO_BUFFER \
        --module IIO_KFIFO_BUF \
        --module IIO_TRIGGERED_BUFFER \
        --enable IIO_TRIGGER \
        --set-val IIO_CONSUMERS_PER_TRIGGER 2 \
        --module HID_SENSOR_IIO_COMMON \
        --module HID_SENSOR_IIO_TRIGGER \
        --module HID_SENSOR_HUB \
        --module HID_SENSOR_ACCEL_3D \
	--module HID_SENSOR_GYRO_3D

yes "" | make olddefconfig

