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
