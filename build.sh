#!/bin/bash

#----------------------------------------------
# Help Menu
#----------------------------------------------
if [ "$1" == "" ] ; then
    echo "\
Please select what you want to build:
    ./build.sh s                       # Setup - Choose board and build options
    ./build.sh t                       # Build Trusted Firmware-A
    ./build.sh u                       # Build u-boot
    ./build.sh k                       # Build Linux Kernel
    ./build.sh m                       # Build Linux Kernel multimedia modules
"
    exit
fi

if [ ! -d "output" ]; then
    mkdir output
fi

if [ "$1" == "u" ] ; then
    ./scripts/build-uboot.sh
    exit
fi

if [ "$1" == "t" ] ; then
    ./scripts/build-atf.sh
    exit
fi

if [ "$1" == "k" ] ; then
    ./scripts/build-kernel.sh
    exit
fi
