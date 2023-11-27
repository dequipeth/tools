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

# Install X Server
apt-get install xserver-xorg-core xserver-xorg-input-all xserver-xorg-video-all xinit x11-xserver-utils --no-install-recommends --assume-yes

# Install KDE
apt-get install plasma-desktop --no-install-recommends --assume-yes
apt-get install plasma-workspace-wayland --no-install-recommends --assume-yes
apt-get install sddm --no-install-recommends --assume-yes
apt-get install plasma-nm --no-install-recommends --assume-yes
apt-get install konsole --no-install-recommends --assume-yes
apt-get install dolphin --no-install-recommends --assume-yes
