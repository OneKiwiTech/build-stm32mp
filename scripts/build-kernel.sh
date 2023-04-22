#!/bin/bash

clone_kernel() {
    if [ ! -d "linux-stm32mp" ]; then
        git clone https://github.com/OneKiwiTech/linux-stm32mp
    fi
}

build_kernel() {
    cd linux-stm32mp
    export KBUILD_OUTPUT=./build
    make multi_v7_build_defconfig
    #make menuconfig
    #make savedefconfig
    make zImage -j8
    make ${DEVICE_NAME}.dtb -j8
}

source ./scripts/build-common.sh
clone_kernel
build_kernel