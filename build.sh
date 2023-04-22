#!/bin/bash

ROOTDIR=`pwd`
PARALLEL=$(getconf _NPROCESSORS_ONLN) # Amount of parallel jobs for the builds

export PATH=$ROOTDIR/build/toolchain/gcc-arm-11.2-2022.02-x86_64-aarch64-none-elf/bin:$PATH
export CROSS_COMPILE=aarch64-none-elf-
export ARCH=arm64


ROOTDIR=`pwd`

sdkname=en.SDK-x86_64-stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23.tar.gz

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
    if [ ! -d "sdk/stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23" ]; then
        if [ -f "sdk/${sdkname}" ]; then
            cd sdk
            echo "extract: ${sdkname}"
            tar -xzvf ${sdkname}
        else 
            echo "${sdkname} does not exist."
        fi
    fi
}

merge_sdk
extract_sdk

