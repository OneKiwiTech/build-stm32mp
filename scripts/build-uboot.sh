#!/bin/bash

clone_uboot() {
    if [ ! -d "uboot-stm32mp" ]; then
        git clone https://github.com/OneKiwiTech/uboot-stm32mp
    fi
}

build_uboot_debug() {
    cd uboot-stm32mp
    export KBUILD_OUTPUT=./build
    make distclean
    make stm32mp15_basic_debug_defconfig
    make DEVICE_TREE=$DEVICE_NAME DDR_INTERACTIVE=1 all -j8
    cp build/u-boot-spl.stm32 ../output
    cd ${ROOTDIR}
}

build_uboot_trusted() {
    cd uboot-stm32mp
    export KBUILD_OUTPUT=./build
    make distclean
    make stm32mp15_trusted_defconfig
    make DEVICE_TREE=$DEVICE_NAME all -j8
    cp build/u-boot-nodtb.bin ../output
    cp build/u-boot.dtb ../output
    cd ${ROOTDIR}
}

source ./scripts/build-common.sh
clone_uboot
build_uboot_debug
#build_uboot_trusted