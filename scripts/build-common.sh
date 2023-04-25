#!/bin/bash

ROOTDIR=`pwd`
PARALLEL=$(getconf _NPROCESSORS_ONLN) # Amount of parallel jobs for the builds

#DEVICE_NAME=stm32mp157c-dk2
DEVICE_NAME=stm32mp151aaa-thatico-r2x512v11
#DEVICE_NAME=stm32mp157caa-thatico-r2x512v10

sdkname=en.SDK-x86_64-stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23.tar.gz
sdkdir=openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23
sdkdirtemp=stm32mp1-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23
openstlinux=st-image-weston-openstlinux-weston-stm32mp1-x86_64-toolchain-4.0.4-openstlinux-5.15-yocto-kirkstone-mp1-v22.11.23.sh

export PATH=$ROOTDIR/$sdkdir/sysroots/x86_64-ostl_sdk-linux/usr/bin/arm-ostl-linux-gnueabi:$PATH
export CROSS_COMPILE=arm-ostl-linux-gnueabi-
export ARCH=arm