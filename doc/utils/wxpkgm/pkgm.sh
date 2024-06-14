#!/bin/bash
################################################################################################
# @file: Package Manager
# @author: Mohamed Ashraf
# @date: 1 Dec 2023
# @version: 1.0.0
# @brief: This file is used for installing packages required for the system
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

# Function to download and install a package
install_package() {
    local name=$1
    local link=$2
    local md5=$3
    local version=$4
    local root_dir="worksapce/"

    # Create a folder for the type
    mkdir -p "${root_dir}/${type}"

    # Create a folder for the name inside the type folder
    mkdir -p "${root_dir}/${type}/${name}"

    # If no link is provided or it's "x", use sudo apt to install the package
    if [ "${link}" == "x" ]; then
        echo "Installing ${name}..."
        sudo apt-get install -y "${name}"
        return
    fi

    # Download the package
    echo "Downloading ${name}..."
    curl -L -o "${root_dir}/${type}/${name}-${version}/downloaded_file" "${link}"
    
    # Check the file extension
    extension="${link##*.}"

    # Install based on the file extension
    case "${extension}" in
        "zip")
            unzip "${root_dir}/${type}/${name}/downloaded_file" -d "${root_dir}/${type}/${name}-${version}"
            ;;
        "tar" | "gz" | "bz2")
            tar -xf "${root_dir}/${type}/${name}/downloaded_file" -C "${root_dir}/${type}/${name}-${version}"
            ;;
        *)
            echo "Unknown file extension: ${extension}"
            exit 1
            ;;
    esac

    # Calculate MD5 of the installed folder
    calculated_md5=$(find "${root_dir}/${type}/${name}-${version}" -type f -exec md5sum {} + | sort -k 2 | md5sum | cut -d ' ' -f 1)

    # Compare MD5
    if [ "${calculated_md5}" == "${md5}" ]; then
        echo "MD5 match for ${name}-${version}. Package installed successfully."
    else
        echo "MD5 mismatch for ${name}-${version}. Installation failed."
    fi
}

# Parse packages from the JSON
packages=$(jq -c '.pkgs[]' pkgs.json)

# Loop through each package
while IFS= read -r package; do
    name=$(echo "${package}" | jq -r '.name')
    version=$(echo "${package}" | jq -r '.version')
    type=$(echo "${package}" | jq -r '.type')
    link=$(echo "${package}" | jq -r '.link')
    md5=$(echo "${package}" | jq -r '.md5')

    # Install the package
    install_package "${name}" "${link}" "${md5}" "${version}"

done <<< "${packages}"
