#!/bin/bash
################################################################################################
# @file: linuxkernel.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to generate linux kernel.
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
# 1. Configure the linux kernel 
# 2. Build the linux kernel system
# 3. Install kernel modules
# ----------------------------------------------------------
# 
# No post-install steps are required.
#
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
source ./utils.sh

# Verify that essential directories exist
check_directory "${LINUX_KERNEL_DIR}"

# The kernel installing modules path
export INSTALL_MOD_PATH="${LINUX_INSTALL_MOD_PATH}"

# Global lock/unlock
make_configuration=$1
make_build=$2
make_install_modules=$3

# First, configure Kernel if requested
if [ "$make_configuration" -eq 1 ]; then
    log_info "Start configuring Kernel"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE="${LINUX_BUILD_CROSS_COMPILER_PREFIX}" -C "${LINUX_KERNEL_DIR}" menuconfig
    check_return $? "Configuring Kernel"
    log_info "Done configuring Kernel"
else
    log_info "Skipping Kernel configuration & adding default configuration ${LINUX_KERNEL_TARGET_DEFCONFIG}"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE="${LINUX_BUILD_CROSS_COMPILER_PREFIX}" -C "${LINUX_KERNEL_DIR}" ${LINUX_KERNEL_TARGET_DEFCONFIG}
    log_info "Done configuring Kernel"
fi

# Third, build kernel modules dtbs if requested
if [ "$make_build" -eq 1 ]; then
    log_info "Start building Kernel-Modules-Dtbs"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE="${LINUX_BUILD_CROSS_COMPILER_PREFIX}" -C "${LINUX_KERNEL_DIR}" zImage modules dtbs
    check_return $? "building Kernel-Modules-Dtbs"
    log_info "Done building Kernel-Modules-Dtbs"
else
    log_info "Skipping Kernel-Modules-Dtbs building."
fi

# Third, install kernel modules if requested
if [ "$make_install_modules" -eq 1 ]; then
    log_info "Start installation Kernel modules"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE="${LINUX_BUILD_CROSS_COMPILER_PREFIX}" -C "${LINUX_KERNEL_DIR}" modules_install
    check_return $? "Installing Kernel modules"
    log_info "Done installation Kernel modules"
else
    log_info "Skipping kernel modules installation."
fi