#!/bin/bash
################################################################################################
# @file: qemu_run.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to deliver a qemu run.
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

# Include constants and utilities
source ./constants.sh
source ./utils.sh

UBOOT_BIN_PATH="/workspace/cots/rpi/Linux_Raspberrypi3b_image/u-boot.bin"

qemu-system-arm -M vexpress-a9 -m 128M -nographic -kernel $UBOOT_BIN_PATH -serial mon:stdio
