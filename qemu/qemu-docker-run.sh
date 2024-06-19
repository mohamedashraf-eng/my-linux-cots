#!bin/bash

# qemu-img create -f qcow2 mytestimage.qcow2 10G

cd qemu-arm-docker/

IMG="https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/aarch64/alpine-virt-3.19.1-aarch64.iso"

docker run -it --rm -e "BOOT=$IMG" -p 8006:8006 --cap-add NET_ADMIN qemux/qemu-arm