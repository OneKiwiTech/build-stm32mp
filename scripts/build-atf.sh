#!/bin/bash

clone_atf() {
    if [ ! -d "atf-stm32mp" ]; then
        git clone https://github.com/OneKiwiTech/atf-stm32mp
    fi
}

build_atf() {
    cd atf-stm32mp
    make PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 AARCH32_SP=sp_min DTB_FILE_NAME=${DEVICE_NAME}.dtb STM32MP_SDMMC=1 STM32MP_EMMC=1 STM32MP_USB_PROGRAMMER=1
    cp build/stm32mp1/release/tf-a-${DEVICE_NAME}.stm32 ../output/tfa-usb.stm32

    make PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 AARCH32_SP=sp_min STM32MP_SDMMC=1 STM32MP_EMMC=1 STM32MP_USB_PROGRAMMER=1 DTB_FILE_NAME=${DEVICE_NAME}.dtb BL33=${ROOTDIR}/output/u-boot-nodtb.bin BL33_CFG=${ROOTDIR}/output/u-boot.dtb fip
    cp build/stm32mp1/release/fip.bin ../output
}

source ./scripts/build-common.sh
clone_atf
build_atf