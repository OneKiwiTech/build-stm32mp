#!/bin/bash

ROOTDIR=`pwd`
PARALLEL=$(getconf _NPROCESSORS_ONLN) # Amount of parallel jobs for the builds

sdkname=en.SDK-x86_64-stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23.tar.gz
sdkdir=openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23
sdkdirtemp=stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23
openstlinux=st-image-weston-openstlinux-weston-stm32mp1-x86_64-toolchain-4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23.sh

export PATH=$ROOTDIR/$sdkdir/sysroots/x86_64-ostl_sdk-linux/usr/bin/arm-ostl-linux-gnueabi:$PATH
export CROSS_COMPILE=arm-ostl-linux-gnueabi-
export ARCH=arm

merge_sdk() {
    if [ ! -f "sdk/${sdkname}" ]; then
        cd sdk
        echo "merge file: ${sdkname}"
        cat ${sdkname}.* > ${sdkname}
        while [ ! -f ${sdkname} ]; do sleep 1; done
        sync
        #exec bash "$1" "$2"
        cd ${ROOTDIR}
    fi
}

extract_sdk() {
    if [ ! -d "sdk/${sdkdirtemp}" ]; then
        if [ -f "sdk/${sdkname}" ]; then
            cd sdk
            echo "extract: ${sdkname}"
            tar -xzvf ${sdkname}
        else 
            echo "${sdkname} does not exist."
        fi
    fi
    cd ${ROOTDIR}
}

setup_sdk() {
    if [ ! -d "${sdkdir}" ]; then
        if [ -d "sdk/${sdkdirtemp}" ]; then
            cd sdk/${sdkdirtemp}/sdk
            ./${openstlinux} -d ${ROOTDIR}/${sdkdir}
        fi
    fi
    cd ${ROOTDIR}
}



clone_uboot() {
    if [ ! -d "uboot-stm32mp" ]; then
        git clone https://github.com/OneKiwiTech/uboot-stm32mp
    fi
}

build_uboot() {
    cd uboot-stm32mp
    export KBUILD_OUTPUT=./build
    make stm32mp15_trusted_defconfig
    make DEVICE_TREE=stm32mp157c-dk2 all -j8
}

merge_sdk
extract_sdk
setup_sdk
clone_uboot
build_uboot

