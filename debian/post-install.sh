#!/bin/bash
# This script performs the post-installation tasks of Debian.
# It must be executed as root.
#
# Thomas DEQUIPE

# Update packages
apt-get update && apt-get upgrade -y

# Install KDE packages
apt-get install plasma-desktop kwin-x11 plasma-workspace-wayland sddm plasma-nm systemsettings dolphin kate konsole --no-install-recommends -y
