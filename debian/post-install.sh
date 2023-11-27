#!/bin/bash
# This script performs the post-installation tasks of Debian.
# It must be executed as root.

# Update packages
apt-get update && apt-get upgrade -y

# Install KDE packages
apt-get install plasma-desktop \
  kwin-x11 plasma-workspace-wayland \
  plymouth-theme-breeze \
  sddm kde-config-sddm sddm-theme-debian-breeze \
  kde-config-screenlocker \
  plasma-nm systemsettings \
  dolphin kate konsole --no-install-recommends -y
