#!/bin/bash
# This script performs the pre-installation tasks of Ubuntu.
# It must be executed as root.
#
# Thomas DEQUIPE


DRIVE="/dev/nvme0n1"

SWAP_INPUT_SIZE="20"
ROOT_INPUT_SIZE="150"
HOME_INPUT_SIZE="150"

EFI_SIZE="1024"
BOOT_SIZE="2048"
SWAP_SIZE="$SWAP_INPUT_SIZE*1024"
ROOT_SIZE="$ROOT_INPUT_SIZE*1024"
HOME_SIZE="$HOME_INPUT_SIZE*1024"

## Partitioning

parted \
  mklabel gpt


parted --script "$DRIVE" \
  mklabel gpt \
  mkpart primary efi 1MiB 1025MiB \
  set 1 esp on \
  mkpart primary boot 1025MiB 3073MiB \
  mkpart primary 3073MiB MiB \
  
