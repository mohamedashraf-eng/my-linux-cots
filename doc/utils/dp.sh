#!/bin/sh
################################################################################################
# @file: Disk Partitioning
# @autor: Mohamed Ashraf
# @date: 1 Dec 2023
# @version: 1.0.0
# @brief: This file is used for partitioning the boot disk.
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

# Function to create a partition using fdisk
create_partition() {
    local device=$1
    local partition=$2
    local size=$3

    echo -e "n\np\n\n\n+${size}\nw" | fdisk "/dev/${device}" &>/dev/null
    echo "Partition ${partition} created on /dev/${device}."
}

# Function to format the partition using mkfs
format_partition() {
    local device=$1
    local partition=$2
    local fs=$3

    mkfs -t "${fs}" "/dev/${device}${partition#p}" &>/dev/null
    echo "Partition ${partition} formatted with ${fs}."
}

# Function to check partition size using lsblk
check_partition_size() {
    local device=$1
    local partition=$2
    local expected_size=$3

    actual_size=$(lsblk -b -n -o SIZE "/dev/${device}${partition}" | awk '{print $1}')

    if [ "${actual_size}" -eq "${expected_size}" ]; then
        echo "Partition ${partition} size is correct."
    else
        echo "Error: Partition ${partition} size mismatch. Expected ${expected_size} bytes, got ${actual_size} bytes."
    fi
}

# Function to parse JSON file
parse_json() {
    local json_file=$1
    local device=$(jq -r '.device' "${json_file}")
    local partitions=$(jq -c '.partitions[]' "${json_file}")

    if [ ! -e "/dev/${device}" ]; then
        echo "Error: Device /dev/${device} does not exist."
        exit 1
    fi

    echo "${device}"
    echo "${partitions}"
}

# Main script
main() {
    local json_file="partition_config.json"
    local device
    local partitions

    read device partitions <<<$(parse_json "${json_file}")

    while IFS= read -r partition_config; do
        local partition=$(echo "${partition_config}" | jq -r '.partition')
        local size=$(echo "${partition_config}" | jq -r '.size')
        local label=$(echo "${partition_config}" | jq -r '.label')
        local fs=$(echo "${partition_config}" | jq -r '.fs')
        local bs=$(echo "${partition_config}" | jq -r '.bs')

        create_partition "${device}" "${partition}" "${size}"
        format_partition "${device}" "${partition}" "${fs}"
        check_partition_size "${device}" "${partition}" "${size}"
    done <<< "${partitions}"

    echo "Disk partitioning completed successfully!"
}

main
