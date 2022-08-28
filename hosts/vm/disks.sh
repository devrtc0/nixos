#!/usr/bin/env sh
set -x

DEVICE="/dev/nvme0n1"

sgdisk --zap-all $DEVICE || exit -1
sgdisk -o $DEVICE
sgdisk -n 1:0:+256M -t 1:ef00 -N 2 -t 2:8300 $DEVICE

sync

BOOT_DEVICE=$(lsblk -p -n -o NAME -x NAME $DEVICE | head -2 | tail -1)
ROOT_DEVICE=$(lsblk -p -n -o NAME -x NAME $DEVICE | tail -1)

yes | mkfs.fat -n boot -F32 "$BOOT_DEVICE"
yes | mkfs.ext4 -L nixos "$ROOT_DEVICE"

sync

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
