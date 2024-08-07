#!/bin/bash
################################################################################################
# @file: sdcard.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to create and partition an SD card image or use an existing one.
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

# NOTE: This file is tested on a Linux Docker image only.

###
# Summary
# This script performs the following steps to create and partition an SD card image:
# 
# - Sources constants and utilities.
# - Creates an output directory for the SD card image.
# - Creates a blank image file of the specified size (if it doesn't exist).
# - Uses fdisk to create a DOS partition table and two partitions (FAT16 and ext4) if creating a new image.
# - Associates the image file with a loop device.
# - Refreshes the partition table.
# - Creates device maps for the partitions using kpartx.
# - Formats the partitions as FAT16 and ext4 if creating a new image.
# - Mounts the FAT16 partition, optionally copies files, and unmounts it.
# - Mounts the ext4 partition, optionally copies files, and unmounts it.
# - Removes the device maps and detaches the loop device.
# - Logs a completion message.
####

# Ensure required tools are installed
# apt-get update
# apt-get install -y udev kpartx util-linux dosfstools

# Include constants and utilities
bash ./constants.sh && source ./constants.sh
bash ./utils.sh && source ./utils.sh

# Path for the image file
FILE_IMG_PATH=${LFS_OUTPUT_DIR}/sdcard/${_LFS_OUTPUT_EXT_DIR}.img

# Create the output directory for the SD card image if it doesn't exist
mkdir -p ${LFS_OUTPUT_DIR}/sdcard/

# Check if the SD card image file already exists
if [ -f "${FILE_IMG_PATH}" ]; then
    log_info "SD card image file already exists. Using the existing image."
else
    # Create a new image file
    log_info "Creating image file..."
    dd if=/dev/zero of=${FILE_IMG_PATH} bs=1M count=${IMAGE_SIZE} status=progress

    # Create partitions using fdisk
    log_info "Partitioning the image file..."
    {
        echo o      # Create a new empty DOS partition table
        echo n      # Add a new partition
        echo p      # Primary partition
        echo 1      # Partition number
        echo        # First sector (Accept default: 2048)
        echo +${FAT_SIZE}M  # Last sector
        echo t      # Change partition type
        echo e      # Set type to W95 FAT16 (LBA)
        echo n      # Add a new partition
        echo p      # Primary partition
        echo 2      # Partition number
        echo        # First sector (Accept default)
        echo        # Last sector (Accept default: remaining space)
        echo w      # Write changes
    } | fdisk ${FILE_IMG_PATH}
fi

# Associate the loop device
LOOP_DEVICE=$(losetup -f --show ${FILE_IMG_PATH})
log_info "Image file mounted as ${LOOP_DEVICE}"
 
# Refresh the partition table
log_info "Refreshing partition table..." 
partprobe ${LOOP_DEVICE}

# Get the loop device name without the /dev/ prefix
LOOP_NAME=$(basename ${LOOP_DEVICE})

# Create device maps for the partitions in the loop device
log_info "Creating device maps for partitions..."
kpartx -av ${LOOP_DEVICE}

# Format the partitions
log_info "Formatting the ${LOOP_NAME} partitions..."
mkfs.fat -F 16 /dev/mapper/${LOOP_NAME}p1
mkfs.ext4 /dev/mapper/${LOOP_NAME}p2

# Mount the FAT16 partition, copy files, and unmount
log_info "Mounting FAT16 partition and copying files..."
mkdir -p /mnt/fat16
mount /dev/mapper/${LOOP_NAME}p1 /mnt/fat16
#############################################################
## Copy files to FAT16 partition
## Run any process before umount
## Uncomment this line to copy a file or directory while processing
copy_item ${FILE_TO_COPY_FAT} /mnt/fat16/ 
#
#############################################################
umount /mnt/fat16
rm -rf /mnt/fat16

# Mount the ext4 partition, copy files, and unmount
log_info "Mounting ext4 partition and copying files..."
mkdir -p /mnt/ext4
mount /dev/mapper/${LOOP_NAME}p2 /mnt/ext4
#############################################################
# Copy files to ext4 partition
## Run any process before umount
## Uncomment this line to copy a file or directory while processing
copy_item ${FILE_TO_COPY_EXT4} /mnt/ext4/
## Commands to run
chmod +x /mnt/ext4/etc/*
chmod +x /mnt/ext4/etc/init.d/*
chmod +x /mnt/ext4/etc/rcS.d/*
chmod +x /mnt/ext4/etc/profile.d/*
#############################################################
umount /mnt/ext4
rm -rf /mnt/ext4

# Remove the device maps and detach the loop device
log_info "Cleaning up..."
kpartx -dv ${LOOP_DEVICE}
losetup -d ${LOOP_DEVICE}

log_info "SD card image created, partitioned, and files copied successfully."
