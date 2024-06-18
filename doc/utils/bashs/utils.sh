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

# Function to copy files or directories with error handling
copy_item() {
    local src=$1
    local dest=$2

    if [ -e "$src" ]; then
        cp -rf "$src" "$dest"
        if [ $? -ne 0 ]; then
            log_error "Failed to copy $src to $dest"
            exit 1
        else
            log_info "Copied $src to $dest"
        fi
    else
        log_error "Source $src does not exist"
        exit 1
    fi
}