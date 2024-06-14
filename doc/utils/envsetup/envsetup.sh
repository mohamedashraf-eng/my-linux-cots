#!/bin/bash
################################################################################################
# @file: Folder Structure Setup
# @autor: Mohamed Ashraf
# @date: 1 Dec 2023
# @version: 1.0.0
# @brief: This file is used for the initial preparation of the LFS folder structure 
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

# Constants
ROOTDIR=/workspace
CROSSNGDIR=$ROOTDIR/crossng
CROSSNG_GITHUBREPO="https://github.com/crosstool-ng/crosstool-ng.git"
CROSSNG_EXPECTED_HASH="your_expected_hash1"
BOOTLOADERSDIR=$ROOTDIR/bootloaders
UBOOTDIR=$BOOTLOADERSDIR/uboot
UBOOT_GITHUBREPO="https://github.com/u-boot/u-boot.git"
UBOOT_EXPECTED_HASH="your_expected_hash2"
GRUBDIR=$BOOTLOADERSDIR/grub
GRUB_GITHUBREPO="https://git.savannah.gnu.org/git/grub.git"
GRUB_EXPECTED_HASH="your_expected_hash3"
LINUXKERNELDIR=$ROOTDIR/kernel/linux
# LINUXKERNEL_GITHUBREPO="https://github.com/torvalds/linux.git"
LINUXKERNEL_GITHUBREPO=""
LINUXKERNEL_EXPECTED_HASH="your_expected_hash4"
BUSYBOXDIR=$ROOTDIR/busybox
BUSYBOX_GITHUBREPO="https://git.busybox.net/busybox"
BUSYBOX_EXPECTED_HASH="your_expected_hash5"
YOCTODIR=$ROOTDIR/yocto
YOCTOPOKYDIR=$YOCTODIR/poky
YOCTOPOKYDIR_GITHUBREPO="https://git.yoctoproject.org/git/poky"
YOCTOPOKYDIR_EXPECTED_HASH="your_expected_hash6"
YOCTOPOKYDUNFELLDIR=$YOCTOPOKYDIR/dunfell
QEMUARMDOCKERDIR=$ROOTDIR/qemu-arm-docker
QEMUARMDOCKER_GITHUBREPO="https://github.com/qemus/qemu-arm.git"
QEMUARMDOCKER_EXPECTED_HASH="your_expected_hash7"
COTSDIR=$ROOTDIR/cots
BOOTCOTSDIR=$COTSDIR/boot_cots
IMGCOTSDIR=$COTSDIR/img_cots
FULLCOTSDIR=$COTSDIR/full_cots

# Variables
active_hash=$1

# Include utility functions
source /workspace/doc/utils/bashs/utils.sh

# Functions

# Function to compute the hash of a directory
compute_directory_hash() {
  local directory=$1
  local hash=$(find "$directory" -type f -exec md5sum {} \; | sort -k 2 | md5sum | awk '{print $1}')
  echo "$hash"
}

validate_directory_content() {
  local directory=$1

  if [ ! -d "$directory" ]; then
    log_error "Directory $directory does not exist."
    return 1
  fi

  if [ -d "$directory/.git" ]; then
    log_info "Valid Git repository found in $directory"
    return 0
  fi

  if [ -f "$directory/LICENSE" ] || [ -f "$directory/Makefile" ] || [ -d "$directory/.github" ]; then
    log_info "Directory $directory contains valid repository files"
    return 0
  fi

  log_warn "Directory $directory does not contain valid repository files"
  return 1
}

clone_repo() {
  local repo_url=$1
  local destination=$2
  local expected_hash=$3

  if validate_directory_content "$destination"; then
    log_info "Repository already exists and is valid: $destination"
    cd "$destination" && git pull origin main > /dev/null 2>&1
    return
  else
    log_info "Invalid repository found or directory does not exist. Cloning afresh: $destination"
    rm -rf "$destination"
  fi

  log_info "Cloning repository: $repo_url into $destination"
  mkdir -p "$destination" && cd "$destination" && git clone "$repo_url" .
  wait

  check_directory "$destination"
  validate_directory_content "$destination"
  log_info "Repository cloned successfully: $repo_url"
}

validate_environment() {
  log_info "Validating environment..."

  # Check if root directory exists
  check_directory "$ROOTDIR"

  # Check other required directories
  check_directory "$CROSSNGDIR"
  check_directory "$BOOTLOADERSDIR"
  check_directory "$UBOOTDIR"
  check_directory "$GRUBDIR"
  check_directory "$LINUXKERNELDIR"
  check_directory "$BUSYBOXDIR"
  check_directory "$COTSDIR"
  check_directory "$BOOTCOTSDIR"
  check_directory "$IMGCOTSDIR"
  check_directory "$FULLCOTSDIR"
  check_directory "$YOCTODIR"
  check_directory "$YOCTOPOKYDIR"
  check_directory "$QEMUARMDOCKERDIR"

  # Validate directory content
  validate_directory_content "$CROSSNGDIR"
  validate_directory_content "$UBOOTDIR"
  validate_directory_content "$GRUBDIR"
  validate_directory_content "$LINUXKERNELDIR"
  validate_directory_content "$BUSYBOXDIR"
  validate_directory_content "$YOCTOPOKYDIR"
  validate_directory_content "$QEMUARMDOCKERDIR"

  log_info "Environment validation successful."
}

# Main
main() {
  log_info "Environment setup - run"
  # Creating the root directory
  mkdir -p "$ROOTDIR"
  cd "$ROOTDIR" || exit

  # Setting up folder structure
  log_info "Creating folder structure..."
  check_directory "$ROOTDIR"
  mkdir -p "$CROSSNGDIR" "$BOOTLOADERSDIR" "$UBOOTDIR" "$GRUBDIR" "$LINUXKERNELDIR" "$BUSYBOXDIR" "$COTSDIR" "$BOOTCOTSDIR" "$IMGCOTSDIR" "$FULLCOTSDIR" "$YOCTODIR" "$YOCTOPOKYDIR" "$QEMUARMDOCKERDIR"
  log_info "Folder structure created."

  # Clone repositories
  log_info "Cloning repos..."
  clone_repo "$CROSSNG_GITHUBREPO" "$CROSSNGDIR" "$CROSSNG_EXPECTED_HASH"
  clone_repo "$UBOOT_GITHUBREPO" "$UBOOTDIR" "$UBOOT_EXPECTED_HASH"
  clone_repo "$GRUB_GITHUBREPO" "$GRUBDIR" "$GRUB_EXPECTED_HASH"
  clone_repo "$LINUXKERNEL_GITHUBREPO" "$LINUXKERNELDIR" "$LINUXKERNEL_EXPECTED_HASH"
  clone_repo "$BUSYBOX_GITHUBREPO" "$BUSYBOXDIR" "$BUSYBOX_EXPECTED_HASH"
  clone_repo "$YOCTOPOKYDIR_GITHUBREPO" "$YOCTOPOKYDIR" "$YOCTOPOKYDIR_EXPECTED_HASH"
  clone_repo "$QEMUARMDOCKER_GITHUBREPO" "$QEMUARMDOCKERDIR" "$QEMUARMDOCKER_EXPECTED_HASH"
  # Validate environment
  validate_environment
}

# Run the main function
main
cd /workspace/doc/utils/envsetup
log_info "Good luck! => :) Mohamed Ashraf [Wx]"
