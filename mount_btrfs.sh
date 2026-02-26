#!/run/current-system/profile/bin/bash

loadkeys fr
mount -o subvol=root /dev/mapper/enc /mnt

cd /mnt

mount -o subvol=home /dev/mapper/enc home
mount -o subvol=gnu /dev/mapper/enc gnu
mount -o subvol=data /dev/mapper/enc data
mount -o subvol=log /dev/mapper/enc var/log
mount -o subvol=swap /dev/mapper/enc swap
mount -o subvol=boot /dev/mapper/enc boot

mount /dev/sda1 /mnt/boot/efi

herd start cow-store /mnt

alias guix-init="guix init /mnt/etc/config.scm /mnt"
