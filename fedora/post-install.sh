#!/bin/bash
# This script performs the post-installation tasks of Fedora.
#
# It must be executed as root.
#
# https://github.com/FrameworkComputer/linux-docs/blob/main/Fedora39-amd-fw13.md
#
# Thomas DEQUIPE


## Configure RPM
function configure_rpm() {
  echo "fastestmirror=True" >> /etc/dnf/dnf.conf
  echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
  echo "defaultyes=True" >> /etc/dnf/dnf.conf
  echo "keepcache=True" >> /etc/dnf/dnf.conf
}


## Upgrade packages
function upgrade_packages() {
  dnf upgrade -y
}


## Install RPM Fusion
function install_rpm_fusion() {
  dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  dnf install \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}


## Install codecs
# https://docs.fedoraproject.org/en-US/quick-docs/installing-plugins-for-playing-movies-and-music/
##
function install_codecs() {
  dnf install gstreamer1-plugins-{bad-\*,good-\*,base} \
    gstreamer1-plugin-openh264 gstreamer1-libav \
    --exclude=gstreamer1-plugins-bad-free-devel
  dnf install lame\* --exclude=lame-devel
  dnf group upgrade --with-optional Multimedia
}


## Install Flathub
function install_flathub() {
  flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
}


## Clean applications
function clean_apps() {
  dnf remove gnome-system-monitor gnome-disk-utility baobab gnome-connections yelp
}


## Configure Gnome
function configure_gnome() {
  # Configure tap to click
  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
  # Configure fractional scaling
  gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
  gsettings set org.gnome.desktop.interface scaling-factor "1.5"
}

