#!/bin/bash
################################################################################################
# @file: constants.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to store system dependent constants
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

# Define constants
# Common
readonly BASE_DIR="/workspace"
readonly NUMBER_OF_PROCESSOR_CORES=$(nproc)
readonly LFS_OUTPUT_DIR="${BASE_DIR}/output"

# Common files @output
# CrossNG
# U-Boot
readonly UBOOT_BIN="${LFS_OUTPUT_DIR}/u-boot.bin"
readonly UBOOT_BIN_SIZE=$(stat -c%s "${UBOOT_BIN}" 2>/dev/null || echo "0")
readonly UBOOT_OUT="${LFS_OUTPUT_DIR}/u-boot"

# Kernel
# BusyBox

########################################################
# Environment Dependent Setup
########################################################

readonly BUILD_CROSS_COMPILER_PATH="/opt/compilers/arm-linux-gnueabihf/bin"
readonly BUILD_CROSS_COMPILER_PREFIX="arm-linux-gnueabihf-"

readonly ARCHITECTURE="arm"

# CrossNG
readonly CROSSNG_DIR="${BASE_DIR}/crossng"
readonly CROSSNG_TARGET="arm-unknown-linux-gnueabi"

# U-Boot
readonly UBOOT_DIR="${BASE_DIR}/bootloaders/uboot"
readonly UBOOT_TARGET="vexpress_ca9x4_defconfig"

# Linux Kernel
readonly LINUX_KERNEL_DIR="${BASE_DIR}/kernel/linux"
readonly LINUX_KERNEL_TARGET_DEFCONFIG="bcm2835_defconfig"
readonly LINUX_INSTALL_MOD_PATH="${BASE_DIR}/output/kernel"

# BusyBox
readonly BUSYBOX_DIR="${BASE_DIR}/busybox"
readonly BUSYBOX_OUTPUT_DIR="${BUSYBOX_DIR}/_install"

# QEMU
readonly QEMU_DIR="${BASE_DIR}/qemu"
readonly QEMU_ARM_DOCKER="${QEMU_DIR}/qemu-arm-docker"

readonly QEMU_TARGET_MACHINE_ARCH="arm"
readonly QEMU_TARGET_MACHINE_CPU="cortex-a9"
readonly QEMU_TARGET_MEMORY="1024M"
readonly QEMU_TARGET_KERNEL="${LFS_OUTPUT_DIR}/u-boot"
readonly QEMU_TARGET_IMAGE=""
readonly QEMU_TARGET_MACHINE="vexpress-a9"
readonly QEMU_EXTRA_OPTIONS="-nographic"

# Source utilities
source ./utils.sh

# Function to display constants
display_constants() {
    log_info "Displaying Constants:"

    log_info "Base Directory: ${BASE_DIR}"
    log_info "Build Cross Compiler Path: ${BUILD_CROSS_COMPILER_PATH}"
    log_info "Build Cross Compiler Prefix: ${BUILD_CROSS_COMPILER_PREFIX}"
    log_info "Architecture: ${ARCHITECTURE}"

    log_info "CrossNG Directory: ${CROSSNG_DIR}"
    log_info "CrossNG Target: ${CROSSNG_TARGET}"

    log_info "U-Boot Directory: ${UBOOT_DIR}"
    log_info "U-Boot Target: ${UBOOT_TARGET}"

    log_info "Linux Kernel Directory: ${LINUX_KERNEL_DIR}"
    log_info "Linux Kernel Target Defconfig: ${LINUX_KERNEL_TARGET_DEFCONFIG}"
    log_info "Linux Install Module Path: ${LINUX_INSTALL_MOD_PATH}"

    log_info "BusyBox Directory: ${BUSYBOX_DIR}"
    log_info "BusyBox Output Directory: ${BUSYBOX_OUTPUT_DIR}"

    log_info "Number of Processor Cores: ${NUMBER_OF_PROCESSOR_CORES}"
    log_info "LFS Output Directory: ${LFS_OUTPUT_DIR}"
}

# Display constants
display_constants