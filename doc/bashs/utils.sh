#!/bin/bash
################################################################################################
# @file: utils.sh
# @autor: Mohamed Ashraf
# @date: 12 June 2024
# @version: 1.0.0
# @brief: This file is used to export utils to other scripts.
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
# Color and format variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BOLD}${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${BOLD}${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${BOLD}${RED}[ERROR]${NC} $1"
}

# Check if a directory exists
check_directory() {
    if [ ! -d "$1" ]; then
        log_error "Directory $1 does not exist."
        
    fi
}

# Check if a file exists
check_file() {
    if [ ! -f "$1" ]; then
        log_error "File $1 does not exist."
        
    fi
}

# Check the return value of a command
check_return() {
    if [ $1 -ne 0 ]; then
        log_error "$2 failed with exit code $1"
        
    fi
}

# Function to compute the hash of a file
compute_file_hash() {
    local file=$1
    local hash=$(sha256sum "$file" | awk '{print $1}')
    echo "$hash"
}

# Function to compare file hash
compare_hash() {
    local file=$1
    local expected_hash=$2
    local actual_hash=$(compute_file_hash "$file")
    
    if [ "$actual_hash" != "$expected_hash" ]; then
        log_error "Hash mismatch for $file. Expected: $expected_hash, Got: $actual_hash"
        
    fi
}
