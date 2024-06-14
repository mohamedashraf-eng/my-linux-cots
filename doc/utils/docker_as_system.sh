#!/bin/bash
################################################################################################
# @file: docker_as_system.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to install the docker envirnoment as native. 
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

# Avoid stuck at console asking for input
export DEBIAN_FRONTEND=noninteractive

# Update package lists and install common tools
sudo apt-get update
sudo apt-get install -y \
    make \
    cmake \
    lsb-release \
    git \
    file \
    aptitude \
    gcc-multilib \
    python3 \
    python3-pip \
    wget \
    qemu-system \
    xz-utils \
    ruby \
    gcc \
    g++ \
    gperf \
    bison \
    flex \
    texinfo \
    help2man \
    libncurses5-dev \
    python3-dev \
    autoconf \
    automake \
    libtool \
    libtool-bin \
    gawk \
    bzip2 \
    unzip \
    patch \
    libstdc++6 \
    rsync \
    libncursesw5-dev \
    diffstat \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3-pexpect \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    python3-subunit \
    zstd \
    liblz4-tool \
    file \
    locales \
    libacl1 \
    gnupg

# Set locale
sudo locale-gen en_US.UTF-8

# Install Docker
## Docker apt repo
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
docker --version
docker-compose --version

# Download and extract ARM GCC compiler
wget -O gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2?rev=78196d3461ba4c9089a67b5f33edf82a&hash=D484B37FF37D6FC3597EBE2877FB666A41D5253B"
sudo mkdir -p /opt/compilers/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux
sudo tar xf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -C /opt/compilers/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux --strip-components=1
rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2

# Download and extract ARM LINUX GNU Compiler
wget -O gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz "https://releases.linaro.org/archive/15.02/components/toolchain/binaries/arm-linux-gnueabihf/gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz"
sudo mkdir -p /opt/compilers/arm-linux-gnueabihf
sudo tar xf gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz -C /opt/compilers/arm-linux-gnueabihf --strip-components=1
rm gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz

# Install ARM GNU Compiler for Linux
sudo apt-get install -y gcc-arm-linux-gnueabihf

# Install gcovr tool
sudo pip3 install gcovr==7.2

# Clean up
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
