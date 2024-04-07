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

DRIVE="/dev/nvme0n1"

SWAP_INPUT_SIZE="${1:-20}"
ROOT_INPUT_SIZE="${2:-150}"
HOME_INPUT_SIZE="${3:-150}"

EFI_SIZE="1024"
BOOT_SIZE="2048"
SWAP_SIZE="$(( $SWAP_INPUT_SIZE * 1024 ))"
ROOT_SIZE="$(( $ROOT_INPUT_SIZE * 1024 ))"
HOME_SIZE="$(( $HOME_INPUT_SIZE * 1024 ))"

echo "efi partition size: $EFI_SIZE"
echo "boot partition size: $BOOT_SIZE"
echo "swap partition size: $SWAP_SIZE"
echo "root partition size: $ROOT_SIZE"
echo "home partition size: $HOME_SIZE"

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


### Installation

# Load keyboard
#loadkeys fr-latin1

# Create partitions

parted --script "$DRIVE" \
  mklabel gpt \
  mkpart primary efi 1MiB 1025MiB \
  set 1 esp on \
  mkpart primary boot 1025MiB 3073MiB \
  mkpart primary 3073MiB MiB \
