#!/bin/bash
################################################################################################
# @file: Folder Structure Setup for Yocto Project
# @author: Mohamed Ashraf
# @date: 1 Dec 2023
# @version: 1.0.0
# @brief: This script sets up the folder structure and environment for a Yocto Project 
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

YOCTO_DIR=$1

# Function to check if the Yocto directory exists
check_existence() {
  if [ ! -d "${YOCTO_DIR}" ]; then
    echo "Invalid Yocto directory passed: ${YOCTO_DIR}"
    exit 1
  fi
}

# Function to set up the environment and install necessary packages
setup() {
  cd "${YOCTO_DIR}" || exit 1

  echo "Installing necessary packages..."
  sudo apt update
  sudo apt install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio \
    python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git \
    python3-jinja2 libegl1-mesa libsdl1.2-dev python3-subunit mesa-common-dev zstd \
    liblz4-tool file locales libacl1 make python3-pip inkscape texlive-latex-extra
  sudo locale-gen en_US.UTF-8

  echo "Installing Python packages..."
  sudo pip3 install sphinx sphinx_rtd_theme pyyaml

  # Clone Yocto meta layers
  echo "Cloning Yocto meta layers..."
  git clone git://git.yoctoproject.org/meta-raspberrypi -b dunfell
  git clone git://git.openembedded.org/meta-openembedded -b dunfell

  if [ ! -d "meta-raspberrypi" ]; then
    echo "Failed to install the Raspberry Pi layer"
    exit 1
  fi

  # Source oe-init-build-env
  echo "Sourcing oe-init-build-env..."
  source oe-init-build-env

  # Ensure the build directory exists and cd to build/
  if [ ! -d "build" ]; then
    bitbake-layers create-layer build
  fi
  cd build/ || exit 1

  # Add meta-raspberrypi to bblayers.conf
  echo "Updating bblayers.conf..."
  echo 'BBLAYERS += "${YOCTO_DIR}/meta-raspberrypi"' >> conf/bblayers.conf

  # Configure local.conf
  echo "Configuring local.conf..."
  cat <<EOL >> conf/local.conf
# Specific needs ## WX
#PREFERRED_VERSION_linux-raspberrypi = "3.%"
DISTRO_FEATURES_remove = "x11 wayland"
DISTRO_FEATURES_BACKFILL_CONSIDERED = "sysvinit"
DISTRO_FEATURES_append = " systemd"
VIRTUAL-RUNTIME_init_manager = "systemd"

# Add more additional output formats
IMAGE_FSTYPES = "tar.xz ext4 rpi-sdimg"

# Increase the rootfs size on mmc
IMAGE_ROOTFS_EXTRA_SPACE_append = " +5000000"

# Add more cores while building
PARALLEL_MAKE = "-j 8"
BB_NUMBER_PARSE_THREADS = "8"
BB_NUMBER_THREADS = "8"

# Enable Serial0 - Uart0
ENABLE_UART = "1"
#IMAGE_INSTALL_append = " rpi-config"
MACHINE_EXTRA_RRECOMMENDS += " bcm2835-bootfiles"

# Add GCC SDK
EXTRA_IMAGE_FEATURES += "tools-sdk"

# Install modules
## Python
IMAGE_INSTALL_append = " python3 python3-pip"

## Openssh
IMAGE_INSTALL_append = " openssh"

## apt-get
#PACKAGE_CLASSES = "package_deb"
PACKAGE_FEED_URIS = "http://192.168.1.5:5678"
EXTRA_IMAGE_FEATURES += " package-management "

## kernel-headers
IMAGE_INSTALL_append = " kernel-dev kernel-devsrc kernel-modules"
TOOLCHAIN_TARGET_TASK_append = " kernel-devsrc"

# Wifi capabilities
IMAGE_INSTALL_append = " linux-firmware-bcm43430 bridge-utils hostapd dhcp-server dhcp-client dhcpcd iptables wpa-supplicant i2c-tools"
DISTRO_FEATURES_append = " wifi"
CORE_IMAGE_EXTRA_INSTALL += "dhcp-server dhcp-client"
EOL
}

# Main script
check_existence
setup

echo "Yocto setup completed successfully!"
