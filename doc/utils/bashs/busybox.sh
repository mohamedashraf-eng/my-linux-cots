#!/bin/bash
################################################################################################
# @file: busybox.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to generate busybox rootfs.
#
# @attention:
# 
# MIT License
# 
# Copyrights © 2024, Mohamed Ashraf
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# **Author Attribution Clause:**
# 
# Any person or organization using, copying, modifying, merging, publishing,
# distributing, sublicensing, or selling copies of the Software must retain the
# name of the original author, Mohamed Ashraf, as the author of the software in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
#################################################################################################

## List of commands to be executed
##################################
# 1. Configure the busybox system for generation.
# 2. Build the busybox rootfs based on the configuration.
# 3. Install the busybox rootfs @ busybox/_install.
# ----------------------------------------------------------
# For deploying after installation.
# Create the required directories to complete rootfs installation on sdcard/virtual[qemu].
# ----------------------------------------------------------
# X-Used
#   make: Build the busybox.
#   ARCH: Architurecture to build aganist.
#   CROSS_COMPILE: Compiler to use for cross compiling.
#   -C: Directory to build in.
#   menuconfig: Build the configuration menu.
#   -j: Number of cores to use.
#   install: Install the busybox.
##

# Include constants and utilities
bash ./constants.sh && source ./constants.sh
bash ./utils.sh && source ./utils.sh


# Verify that essential directories exist
check_directory "${BUSYBOX_DIR}"

# Global lock/unlock
make_configuration=$1
make_build=$2
make_install=$3

# First, configure BusyBox if requested
if [ "$make_configuration" -eq 1 ]; then
    log_info "Start configuring BusyBox"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE="${BUILD_CROSS_COMPILER_PREFIX}" -C "${BUSYBOX_DIR}" menuconfig
    check_return $? "Configuring BusyBox"
    log_info "Done configuring BusyBox"
else
    log_info "Skipping BusyBox configuration"
fi

# Second, build BusyBox if requested
if [ "$make_build" -eq 1 ]; then
    log_info "Start building BusyBox"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE="${BUILD_CROSS_COMPILER_PREFIX}" -C "${BUSYBOX_DIR}" -j"${NUMBER_OF_PROCESSOR_CORES}"
    check_return $? "Building BusyBox"
    log_info "Done building BusyBox"
else
    log_info "Skipping BusyBox build"
fi

# Third, install BusyBox if requested
if [ "$make_install" -eq 1 ]; then
    log_info "Start installing BusyBox"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE="${BUILD_CROSS_COMPILER_PREFIX}" -C "${BUSYBOX_DIR}" -j"${NUMBER_OF_PROCESSOR_CORES}" install
    check_return $? "Installing BusyBox"
    log_info "Done installing BusyBox"
else
    log_info "Skipping BusyBox installation"
fi

log_info "Adding rootfs directories (Completing)"

check_directory "${BUSYBOX_OUTPUT_DIR}"

# Create necessary directories and set permissions
log_info "Creating additional directories in the BusyBox output"
#   /proc: This directory contains virtual files that provide a window into the kernel. It is used to access process information and other system information.
mkdir -p "${BUSYBOX_OUTPUT_DIR}/proc"
#   /sys: Another virtual filesystem that provides information about the kernel, hardware devices, and associated device drivers.
mkdir -p "${BUSYBOX_OUTPUT_DIR}/sys"
#   /dev: Contains device files, which provide an interface to kernel devices. For example, /dev/sda might refer to a hard disk.
mkdir -p "${BUSYBOX_OUTPUT_DIR}/dev"
#   /etc: Configuration files for the system and applications. Commonly contains initialization scripts, configuration files for services, and system-wide configuration files.
mkdir -p "${BUSYBOX_OUTPUT_DIR}/etc"
#   /etc/init.d: This directory contains scripts used by the init process to start and stop system services.
mkdir -p "${BUSYBOX_OUTPUT_DIR}/etc/init.d"

# Ensure rcS script is in place and executable
if [ -f "${BUSYBOX_OUTPUT_DIR}/etc/init.d/rcS" ]; then
    log_info "rcS script found in ${BUSYBOX_OUTPUT_DIR}/etc/init.d/"
else
    log_warn "rcS script not found in ${BUSYBOX_OUTPUT_DIR}/etc/init.d/"
    log_info "Creating rcS script @${BUSYBOX_OUTPUT_DIR}/etc/init.d/"
    touch "${BUSYBOX_OUTPUT_DIR}/etc/init.d/rcS"
fi
chmod +x "${BUSYBOX_OUTPUT_DIR}/etc/init.d/rcS"
log_info "Set execute permission on rcS script"

log_info "Writing content into rcS"
cat <<EOL > "${BUSYBOX_OUTPUT_DIR}/etc/init.d/rcS"
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
echo "/sbin/mdev" > "proc/sys/kernel/hotplug"
mdev -s  # Scan /sys and populate /dev
EOL
log_info "Done writing content into rcS"
#
# TODO: Copy the generated `lib` directory from linux kernel build to the rootfs.

log_info "Root filesystem setup completed"
#
copy_target "${BUSYBOX_OUTPUT_DIR}" "${LFS_OUTPUT_DIR}"/rootfs


log_info "BusyBox setup completed"

