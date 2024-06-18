#!/bin/bash
################################################################################################
# @file: constants.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to generate busybox rootfs.
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
##
# !IMPORTANT
# Dependencies:
#   apt-get install -y gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
#   python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
#   patch libstdc++6 rsync
#

# Include constants and utilities
bash ./constants.sh && source ./constants.sh
bash ./utils.sh && source ./utils.sh

# Verify that essential directories exist
check_directory "${CROSSNG_DIR}"

# Global lock/unlock
make_init=$1
make_configuration=$2
make_build=$3
make_install=$4

# Generate configurations (initalize)
if [ "$make_init" -eq 1 ]; then
    log_info "Start initalizing crossng"
    log_info "Bootstraping"
    cd "${CROSSNG_DIR}"
    ./bootstrap
    check_return $? "initalizing crossng"
    #
    make -C"${CROSSNG_DIR}" distclean
    log_info "Base configuration" 
    # ./configure --enable-local
    check_return $? "confgiuring base"
    log_info "Setup ct-ng configuration"
    make -C"${CROSSNG_DIR}" -j"${NUMBER_OF_PROCESSOR_CORES}"
    #
    log_info "Selecting the target" 
    "${CROSSNG_DIR}"/ct-ng list-samples
    "${CROSSNG_DIR}"/ct-ng "${CROSSNG_TARGET}"
    log_info "Done initalizing crossng"
else
    log_info "Skipping crossng initlization"
fi

# First, configure Crossng if requested
if [ "$make_configuration" -eq 1 ]; then
    log_info "Start configuring Crossng"
    $CROSSNG_DIR/ct-ng menuconfig
    check_return $? "Configuring Crossng"
    log_info "Done configuring Crossng"
else
    log_info "Skipping Crossng configuration"
fi

# Second, Build the crossng toolchain
if [ "$make_build" -eq 1 ]; then
    log_info "Start building Crossng"
    "${CROSSNG_DIR}"/ct-ng build
    check_return $? "building Crossng"
    log_info "Done building Crossng"
else
    log_info "Skipping Crossng build" 
fi