#!/usr/bin/env sh

RED='\033[0;31m'
NC='\033[0m' # No Color
check () {
	if [ $? -ne 0 ]; then
		printf "${RED}ERROR${NC}"
		exit -1
	fi
}

set -x

umount -qR /mnt
check

DEVICE="/dev/nvme0n1"

sgdisk --zap-all $DEVICE
check
sgdisk -o $DEVICE
check
sgdisk -n 1:0:+256M -t 1:ef00 -N 2 -t 2:8300 $DEVICE
check

sync

BOOT_DEVICE=$(lsblk -p -n -o NAME -x NAME $DEVICE | head -2 | tail -1)
ROOT_DEVICE=$(lsblk -p -n -o NAME -x NAME $DEVICE | tail -1)

yes | mkfs.fat -n boot -F32 "$BOOT_DEVICE"
check
yes | mkfs.ext4 -L nixos "$ROOT_DEVICE"
check

sync

mount /dev/disk/by-label/nixos /mnt
check
mkdir -p /mnt/boot
check
mount /dev/disk/by-label/boot /mnt/boot
check

set +x
