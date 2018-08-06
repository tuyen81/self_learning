#!/bin/sh
#sudo mount --bind -o rw,nosuid,nodev,noexec /dev  chroot-jessie/dev
sudo mount --bind -o rw,nosuid,nodev,noexec /dev/pts chroot-jessie/dev/pts
sudo mount --bind -o rw,nosuid,nodev,noexec /dev/shm chroot-jessie/dev/shm
sudo mount --bind /proc chroot-jessie/proc

