################################################################################################
# @file: constants.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to store system dependent constants
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

# Define constants
readonly BASE_DIR="/workspace"
readonly BUILD_CROSS_COMPILER_PATH="/opt/compilers/arm-linux-gnueabihf/bin"
readonly BUILD_CROSS_COMPILER_PREFIX="arm-linux-gnueabihf-"

readonly ARCHITECTURE="arm"

# crossng
readonly CROSSNG_DIR="${BASE_DIR}/crossng"
readonly CROSSNG_TARGET="arm-unknown-linux-gnueabi"

# u-boot
readonly UBOOT_DIR="${BASE_DIR}/u-boot"
readonly UBOOT_TARGET="rpi_3_b_plus_defconfig"

# Linux Kernel
readonly LINUX_KERNEL_DIR="${BASE_DIR}/linux"
readonly LINUX_KERNEL_TARGET_DEFCONFIG="bcm2835_defconfig"
readonly LINUX_INSTALL_MOD_PATH="${BASE_DIR}/output/kernel"

# Busybox
readonly BUSYBOX_DIR="${BASE_DIR}/busybox"
readonly BUSYBOX_OUTPUT_DIR="${BUSYBOX_DIR}/_install"

# Usually used
readonly NUMBER_OF_PROCESSOR_CORES=$(nproc)

readonly LFS_OUTPUT_DIR="${BASE_DIR}/lfs/out"