# Build librealsense2 for Jetson TK1
Build librealsense 2.0 library on the NVIDIA Jetson TK1 Development kit. Jetson TX1 and Jetson TX2. Intel RealSense D400 series cameras.

This is for
* L4T 21.5
* librealsense v2.21.0
* Linux Kernel 3.10.40-ga7da876

May, 2019

In order for librealsense to work properly, the kernel image must be rebuilt and patches applied to the UVC module and some other support modules. Running installLibrealsense.sh alone will appear to make the camera mostly work but will be missing features such as frame metadata support ( https://github.com/IntelRealSense/librealsense/blob/master/doc/frame_metadata.md ).

<h2>Rebuilding the kernel</h2>
The Jetsons have the v4l2 module built into the kernel image. The module should not be built as an external module, due to needed support for the carrier board camera. Because of this, a separate kernel Image should be generated, as well as any needed modules (such as the patched UVC module).

In order to support Intel RealSense cameras with built in accelerometers and gyroscopes, modules need to be enabled. These modules are in the Industrial I/O (<strong> IIO</strong> ) device tree. The Jetson already has IIO support enabled in the kernel image to support the INA3321x power monitors. To support these other HID IIO devices, IIO_BUFFER must be enabled; it must be built into the kernel Image as well.

Most developers will want to apply the needed patches, configure the kernel .config file to match their desired environment, and then build their kernel Image and modules. The scripts assumes that the source is in the usual place for the Jetson, i.e. /usr/src/kernel/kernel, though you may want to change it to match your needs. <strong>Note: </strong>You can examine buildPatchedKernel.sh for the general outline of building the kernel.

The script scripts/patchKernel.sh will patch the kernel modules and Image to support the librealsense2 cameras. 

$ sudo ./scripts/patchKernel.sh

The kernel configuration modifications are in the scripts/configureKernel.sh script.

$ sudo ./scripts/configureKernel.sh

This script modifies the Industrial I/O device modules as needed and then ensures that any dependencies are met. The script also sets the local version to the local version of the current kernel. See the script for more details.

<em><strong>Note: </strong>The configureKernel.sh script sets the local version of the kernel to be the current local version, ie -tegra on a stock kernel. If that is not your intention, modify configureKernel.sh appropriately.</em>

<h3>A alternative</h3>

There is a script which downloads the kernel source, patches it, builds a new kernel and installs it.

$ ./buildPatchedKernel.sh


By default, the kernel sources will be erased from the disk after the kernel has been compiled and installed. You will need >3GB of disk space to build the kernel in this manner. Please note that you should do this on a freshly flashed system. In the case when something goes wrong, it may make the system fail and become unresponsive; the only way to recover may be to use JetPack to reflash.

The script has an option to keep the kernel sources and build information:

$ ./buildPatchedKernel.sh --nocleanup

which may prove useful for debugging purposes.

The script is more provided as a guide on how to build a system that supports librealsense2 than as a practical method to generate a new system.

<h2>Install librealsense 2.0</h2>
To install the librealsense library:

$ ./installLibrealsense.sh

The install script does the following:

<ul>
<li>Install dependencies</li>
<li>Applies Jetson specific patches</li>
<li>Sets up udev rules so the camera may be used in user space</li>
<li>Builds librealsense, tools and demos</li>
<li>Installs libraries and executables</li>
</ul>

<h3>Tracking Module</h3>
Some RealSense cameras have a tracking module. Here's some more info on that:

TM1-specifics:
Tracking Module requires *hid_sensor_custom* kernel module to operate properly.
Due to TM1's power-up sequence constrains, this driver is required to be loaded during boot for the HW to be properly initialized.

In order to accomplish this add the driver's name *hid_sensor_custom* to `/etc/modules` file, eg:

$ echo 'hid_sensor_custom' | sudo tee -a /etc/modules`

MIT License

Copyright (c) 2017-2018 Jetsonhacks 
Portions Copyright (c) 2015-2018 Raffaello Bonghi (jetson_easy)
Portions Copyright (c) 2016 Mehran Maghoumi
Portions Copyright (c) 2019 Mario Lüder

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

