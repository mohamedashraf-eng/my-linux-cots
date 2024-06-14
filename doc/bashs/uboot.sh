#!/bin/bash
################################################################################################
# @file: uboot.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to generate u-boot.
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
# 1. 
# 2. 
# 3. 
# ----------------------------------------------------------
# 
# 
# ----------------------------------------------------------
# X-Used
#   make: Build the uboot.
#   ARCH: Architurecture to build aganist.
#   CROSS_COMPILE: Compiler to use for cross compiling.
#   -C: Directory to build in.
#   menuconfig: Build the configuration menu.
#   -j: Number of cores to use.
#   install: Install the uboot.
##

# Include constants and utilities
source ./constants.sh
source ./utils.sh

# Verify that essential directories exist
check_directory "${UBOOT_DIR}"

# Global lock/unlock
make_configuration=$1
make_build=$2

# First, configure uboot if requested
if [ "$make_configuration" -eq 1 ]; then
    log_info "Start add target uboot"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE=${BUILD_CROSS_COMPILER_PREFIX} -C "${UBOOT_DIR}" "${UBOOT_TARGET}"
    check_return $? "add target uboot"
    log_info "Done add target uboot"
    # Configure uboot
    log_info "Start configuring uboot"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE=${BUILD_CROSS_COMPILER_PREFIX} -C "${UBOOT_DIR}" menuconfig
    check_return $? "add configuring uboot"
    log_info "Done configuring uboot"
fi

# Second, configure uboot if requested
if [ "$make_build" -eq 1 ]; then
    log_info "Start building uboot"
    make ARCH="${ARCHITECTURE}" CROSS_COMPILE=${BUILD_CROSS_COMPILER_PREFIX} -C "${UBOOT_DIR}" -j"${NUMBER_OF_PROCESSOR_CORES}"
    check_return $? "building uboot"
    log_info "Done building uboot"
else
    log_info "Skipping uboot build"
fi