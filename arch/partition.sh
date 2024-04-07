#!/bin/bash
# This script performs the installation of Arch Linux.
# It must be executed as root.
#
# Thomas DEQUIPE


### Variables

EFI_PART=""
BOOT_PART=""
SWAP_PART=""
ROOT_PART=""
HOME_PART=""

DRIVE="$1"
DRIVE_SIZE="$(( $( lsblk -b | grep $DRIVE | head -n 1 | awk '{ print $4 }' ) / 1024 / 1024 ))"

echo "drive size: $DRIVE_SIZE MB"

SWAP_INPUT_SIZE="${2:-6}"
ROOT_INPUT_SIZE="${3:-20}"
HOME_INPUT_SIZE="${4:-10}"

if ! [[ "$SWAP_INPUT_SIZE" =~ ^[0-9]+$ ]]; then
	echo "the swap partition size input is not a number"
	exit
fi

if ! [[ "$ROOT_INPUT_SIZE" =~ ^[0-9]+$ ]]; then
	echo "the root partition size input is not a number"
	exit
fi

if ! [[ "$HOME_INPUT_SIZE" =~ ^[0-9]+$ ]]; then
	echo "the home partition size input is not a number"
	exit
fi

if [[ $SWAP_INPUT_SIZE < 6 ]]; then
	echo "the swap partition size is not large enough"
	exit
fi

if [[ $ROOT_INPUT_SIZE < 20 ]]; then
	echo "the root partition size is not large enough"
	exit
fi

if [[ $HOME_INPUT_SIZE < 10 ]]; then
	echo "the home partition size is not large enough"
	exit
fi

EFI_SIZE="1024"
BOOT_SIZE="2048"
SWAP_SIZE="$(( $SWAP_INPUT_SIZE * 1024 ))"
ROOT_SIZE="$(( $ROOT_INPUT_SIZE * 1024 ))"
HOME_SIZE="$(( $HOME_INPUT_SIZE * 1024 ))"

PART_SIZE="$(( $EFI_SIZE + $BOOT_SIZE + $SWAP_SIZE + $ROOT_SIZE + $HOME_SIZE ))"

echo "drive size: $DRIVE_SIZE"
echo "partition size: $PART_SIZE"

if ! [[ $PART_SIZE < $DRIVE_SIZE ]]; then
	echo "the is not enough space on the drive"
	exit
fi

echo "efi partition size: $EFI_SIZE MB"
echo "boot partition size: $BOOT_SIZE MB"
echo "swap partition size: $SWAP_SIZE MB"
echo "root partition size: $ROOT_SIZE MB"
echo "home partition size: $HOME_SIZE MB"

EFI_END="$(( $EFI_SIZE + 1 ))"
BOOT_END="$(( $EFI_SIZE + $BOOT_SIZE + 1 ))"
SWAP_END="$(( $EFI_SIZE + $BOOT_SIZE + $SWAP_SIZE + 1 ))"
ROOT_END="$(( $EFI_SIZE + $BOOT_SIZE + $SWAP_SIZE + $ROOT_SIZE + 1 ))"
HOME_END="$(( $EFI_SIZE + $BOOT_SIZE + $SWAP_SIZE + $ROOT_SIZE + $HOME_SIZE + 1 ))"

echo "efi partition end: $EFI_END"
echo "boot partition end: $BOOT_END"
echo "swap partition end: $SWAP_END"
echo "root partition end: $ROOT_END"
echo "home partition end: $HOME_END"


### Create partitions

