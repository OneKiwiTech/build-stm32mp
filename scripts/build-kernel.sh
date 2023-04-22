#!/bin/bash

clone_kernel() {
    if [ ! -d "linux-stm32mp" ]; then
        git clone https://github.com/OneKiwiTech/linux-stm32mp
    fi
}

build_kernel() {
    cd linux-stm32mp
    export KBUILD_OUTPUT=./build
    make stm32mp15_trusted_defconfig
    make DEVICE_TREE=stm32mp157c-dk2 all -j8
    cd ${ROOTDIR}
}

source ./scripts/build-common.sh
clone_kernel
#build_kernel