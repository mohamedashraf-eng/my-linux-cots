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
bash ./constants.sh && source ./constants.sh
bash ./utils.sh && source ./utils.sh

# Verify that essential directories exist
check_directory $UBOOT_DIR

# Global lock/unlock
make_configuration=$1
make_build=$2

# First, configure uboot if requested
if [ "$make_configuration" -eq 1 ]; then
    log_info "Start add target uboot"
    make ARCH=$ARCHITECTURE CROSS_COMPILE=$BUILD_CROSS_COMPILER_PREFIX -C $UBOOT_DIR "$UBOOT_TARGET"
    check_return $? "add target uboot"
    log_info "Done add target uboot"
    # Configure uboot
    log_info "Start configuring uboot"
    make ARCH=$ARCHITECTURE CROSS_COMPILE=$BUILD_CROSS_COMPILER_PREFIX -C $UBOOT_DIR menuconfig
    check_return $? "add configuring uboot"
    log_info "Done configuring uboot"
fi

# Second, configure uboot if requested
if [ "$make_build" -eq 1 ]; then
    log_info "Start building uboot"
    make ARCH=$ARCHITECTURE CROSS_COMPILE=$BUILD_CROSS_COMPILER_PREFIX -C $UBOOT_DIR -j$NUMBER_OF_PROCESSOR_CORES
    check_return $? "building uboot"
    log_info "Done building uboot"
else
    log_info "Skipping uboot build"
fi

# Check and copy u-boot files if they exist
if [ -f "$UBOOT_DIR/u-boot.bin" ] && [ -f "$UBOOT_DIR/u-boot" ]; then
    log_info "Redirecting u-boot & u-boot.bin"
    cp "$UBOOT_DIR/u-boot.bin" "$LFS_OUTPUT_DIR"
    cp "$UBOOT_DIR/u-boot" "$LFS_OUTPUT_DIR"
    log_info "Done redirecting u-boot & u-boot.bin"
else
    if [ ! -f "$UBOOT_DIR/u-boot.bin" ]; then
        log_error "u-boot.bin does not exist in $UBOOT_DIR"
    fi
    if [ ! -f "$UBOOT_DIR/u-boot" ]; then
        log_error "u-boot does not exist in $UBOOT_DIR"
    fi
fi

log_info "Copying depenencies"

copy_target ${UBOOT_DIR}/u-boot.bin ${LFS_OUTPUT_DIR}
copy_target ${UBOOT_DIR}/u-boot ${LFS_OUTPUT_DIR}

log_info "Done copying depenencies"