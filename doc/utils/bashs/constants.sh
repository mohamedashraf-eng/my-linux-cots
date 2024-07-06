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

########################################################
# Common Constants
########################################################

# Base directory for all operations
readonly BASE_DIR="/workspace"

# Number of processor cores available
readonly NUMBER_OF_PROCESSOR_CORES=$(nproc)

# Output directory for all build artifacts
readonly _LFS_OUTPUT_EXT_DIR="vexpress_v2p_ca9"
readonly LFS_OUTPUT_DIR="${BASE_DIR}/output/${_LFS_OUTPUT_EXT_DIR}"

########################################################
# Cross Compiler Configuration
########################################################

# Path to the cross-compiler binaries
readonly BUILD_CROSS_COMPILER_PATH="/opt/compilers/arm-linux-gnueabihf/bin"

# Prefix for the cross-compiler tools
readonly BUILD_CROSS_COMPILER_PREFIX="arm-linux-gnueabihf-"
# readonly BUILD_CROSS_COMPILER_PREFIX="aarch64-linux-gnu-"

# Target architecture
readonly ARCHITECTURE="arm"

########################################################
# CrossNG Configuration
########################################################

# Directory for CrossNG toolchain
readonly CROSSNG_DIR="${BASE_DIR}/crossng"

# Target triple for CrossNG
readonly CROSSNG_TARGET="arm-cortexa9_neon-linux-gnueabihf"

########################################################
# U-Boot Configuration
########################################################

# Directory for U-Boot source
readonly UBOOT_DIR="${BASE_DIR}/bootloaders/uboot"

# U-Boot target configuration
readonly UBOOT_TARGET="vexpress_ca9x4_defconfig"

# U-Boot binary output file
readonly UBOOT_BIN="${LFS_OUTPUT_DIR}/u-boot.bin"

# Size of the U-Boot binary
readonly UBOOT_BIN_SIZE=$(stat -c%s "${UBOOT_BIN}" 2>/dev/null || echo "0")

# U-Boot output directory
readonly UBOOT_OUT="${LFS_OUTPUT_DIR}/u-boot"

########################################################
# Linux Kernel Configuration
########################################################

# Directory for Linux kernel source
readonly LINUX_KERNEL_DIR="${BASE_DIR}/kernel/linux/base"

# Default configuration for the Linux kernel
readonly LINUX_KERNEL_TARGET_DEFCONFIG="vexpress_defconfig"

readonly LINUX_TARGET_SOC_OEM="arm"

readonly LINUX_TARGET_DTB_NAME="vexpress-v2p-ca9.dtb"

# Directory for installing Linux kernel modules
readonly LINUX_INSTALL_MOD_PATH="${BASE_DIR}/output/kernel"

########################################################
# BusyBox Configuration
########################################################

# Directory for BusyBox source
readonly BUSYBOX_DIR="${BASE_DIR}/busybox"

# Output directory for BusyBox installation
readonly BUSYBOX_OUTPUT_DIR="${BUSYBOX_DIR}/_install"

########################################################
# QEMU Configuration
########################################################

# Directory for QEMU source
readonly QEMU_DIR="${BASE_DIR}/qemu"

# Docker image for QEMU ARM
readonly QEMU_ARM_DOCKER="${QEMU_DIR}/qemu-arm-docker"

# Target machine architecture for QEMU
readonly QEMU_TARGET_MACHINE_ARCH="arm"

# Target machine CPU for QEMU
readonly QEMU_TARGET_MACHINE_CPU="armv8"

# System on Chip for QEMU target machine
readonly QEMU_TARGET_MACHINE_SOC="arm"

# Memory size for QEMU target machine
readonly QEMU_TARGET_MEMORY="128M"

# Kernel for QEMU target machine
readonly QEMU_TARGET_KERNEL="${LFS_OUTPUT_DIR}/boot/zImage"

# DTB for QEMU target machine
readonly QEMU_TARGET_DTB="${LFS_OUTPUT_DIR}/boot/vexpress-v2p-ca9.dtb"

# Disk image for QEMU target machine
readonly QEMU_TARGET_IMAGE=""

# Rootfs to be loaded by the kernel
readonly QEMU_TARGET_ROOTFS=""

# Machine type for QEMU
readonly QEMU_TARGET_MACHINE="vexpress-a9"

readonly QEMU_EXTRA_OPTIONS="
-nographic \
-append \"console=ttyAMA0,115200 root=/dev/mmcblk0p2 rw \" \
-sd ${LFS_OUTPUT_DIR}/sdcard/${_LFS_OUTPUT_EXT_DIR}.img
"
########################################################
# Disk Configuration
########################################################

IMAGE_SIZE=${IMAGE_SIZE:-1024} # in MB

FAT_SIZE=${FAT_SIZE:-512}      # in MB

EXT4_SIZE=${EXT4_SIZE:-512}    # in MB

FILE_TO_COPY_FAT="${LFS_OUTPUT_DIR}/boot/."

FILE_TO_COPY_EXT4="${LFS_OUTPUT_DIR}/rootfs/."

########################################################
# Utility Functions
########################################################

# Source additional utilities
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

    log_info "QEMU Directory: ${QEMU_DIR}"
    log_info "QEMU ARM Docker Image: ${QEMU_ARM_DOCKER}"
    log_info "QEMU Target Machine Architecture: ${QEMU_TARGET_MACHINE_ARCH}"
    log_info "QEMU Target Machine CPU: ${QEMU_TARGET_MACHINE_CPU}"
    log_info "QEMU Target Machine SoC: ${QEMU_TARGET_MACHINE_SOC}"
    log_info "QEMU Target Memory: ${QEMU_TARGET_MEMORY}"
    log_info "QEMU Target Kernel: ${QEMU_TARGET_KERNEL}"
    log_info "QEMU Target Image: ${QEMU_TARGET_IMAGE}"
    log_info "QEMU Target Machine: ${QEMU_TARGET_MACHINE}"
    log_info "QEMU Extra Options: ${QEMU_EXTRA_OPTIONS}"

    log_info "Number of Processor Cores: ${NUMBER_OF_PROCESSOR_CORES}"
    log_info "LFS Output Directory: ${LFS_OUTPUT_DIR}"
}

# Display constants
display_constants
