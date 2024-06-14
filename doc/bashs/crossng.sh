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
source ./constants.sh
source ./utils.sh

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