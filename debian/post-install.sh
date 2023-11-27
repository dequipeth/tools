#!/bin/bash
# This script performs the post-installation tasks of Debian.
# It must be executed as root.


## Update packages
apt-get update && apt-get upgrade -y


## Install system utilities
apt-get install git vim -y


## Install X Server
apt-get install xserver-xorg-core xserver-xorg-input-all xserver-xorg-video-all xinit x11-xserver-utils --no-install-recommends -y


## Install KDE

# KDE Plasma Desktop
apt-get install plasma-desktop --no-install-recommends -y
# KDE Plasma Wayland
apt-get install plasma-workspace-wayland --no-install-recommends -y
# Simple Desktop Display Manager 
apt-get install sddm kde-config-sddm sddm-theme-debian-breeze --no-install-recommends -y
# KDE Screen Manager
apt-get install kscreen --no-install-recommends -y
# KDE Plasma Network Manager
apt-get install plasma-nm --no-install-recommends -y
# KDE Screen Locker
apt-get install kde-config-screenlocker --no-install-recommends -y
# KDE Console Emulator
apt-get install konsole --no-install-recommends -y
# KDE File Manager
apt-get install dolphin --no-install-recommends -y
