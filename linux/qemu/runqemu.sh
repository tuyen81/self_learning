#!/bin/bash

KERNEL="./bzImage-qemux86-64.bin"
ROOTFS="./core-image-minimal-qemux86-64.ext4"
MEM=1024

options="-net nic,model=virtio"
options+=" -net tap,vlan=0,ifname=tap0,script=no,downscript=no"
options+=" -cpu core2duo"
options+=" -drive file=${ROOTFS},if=virtio,format=raw"
options+=" -show-cursor"
options+=" -usb -usbdevice wacom-tablet"
options+=" -vga vmware"
options+=" -no-reboot -nographic"
options+=" -m ${MEM}"
options+=" -serial mon:stdio -serial null"

cmdline="vga=0 uvesafb.mode_option=640x480-32 root=/dev/vda rw mem=${MEM}M"
cmdline+=" ip=192.168.7.2::192.168.7.1:255.255.255.0 oprofile.timer=1"
cmdline+=" rootfstype=ext4 console=ttyS0 "

qemu-system-x86_64 -kernel ${KERNEL} ${options} --append "${cmdline}"
