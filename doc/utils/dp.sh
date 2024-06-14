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
