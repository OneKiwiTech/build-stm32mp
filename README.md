# build stm32mp
- `cd output`
- `STM32_Programmer_CLI -c port=usb1 -w u-boot-spl.stm32 0x01 --start 0x01`
- `STM32_Programmer_CLI -c port=usb1 -d tfa-usb.stm32 0x1 -s 0x1 -d fip.bin 0x3 -s 0x3`