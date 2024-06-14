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
#    Copyright (C) <2023>  <Mohamed Ashraf>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
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
source ./constants.sh
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