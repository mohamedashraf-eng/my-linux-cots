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

# Include constants and utilities
bash ./constants.sh && source ./constants.sh
bash ./utils.sh && source ./utils.sh

# Define the QEMU command base
qemu_cmd="qemu-system-${QEMU_TARGET_MACHINE_ARCH} \
    -M \"${QEMU_TARGET_MACHINE}\" \
    -m \"${QEMU_TARGET_MEMORY}\" \
    -kernel \"${QEMU_TARGET_KERNEL}\""

# Check if QEMU_TARGET_DTB is not empty and add it to the command
if [ -n "${QEMU_TARGET_DTB}" ]; then
    qemu_cmd="${qemu_cmd} -dtb \"${QEMU_TARGET_DTB}\""
fi

# Add extra options
qemu_cmd="${qemu_cmd} ${QEMU_EXTRA_OPTIONS}"

# Execute the QEMU command
eval ${qemu_cmd}

# Check return value of QEMU execution
check_return $? "QEMU execution"