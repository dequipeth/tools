#!/bin/bash
# This script performs the pre-installation tasks of Fedora.
# It must be executed as root.
#
# Thomas DEQUIPE


SWAP_INPUT_SIZE="20"
ROOT_INPUT_SIZE="150"
HOME_INPUT_SIZE="150"

EFI_SIZE="1024"
BOOT_SIZE="2048"
SWAP_SIZE="$SWAP_INPUT_SIZE*1024"
ROOT_SIZE="$ROOT_INPUT_SIZE*1024"
HOME_SIZE="$HOME_INPUT_SIZE*1024"
