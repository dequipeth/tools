#!/bin/bash
# This script removes Snap from Ubuntu.
#
# It must be executed as root.
#
# Thomas DEQUIPE


## Remove Snap packages
snap remove --purge firefox
snap remove --purge snap-store
snap remove --purge gnome-3-38-2004
snap remove --purge gnome-42-2204
snap remove --purge gtk-common-themes
snap remove --purge snapd-desktop-integration
snap remove --purge bare
snap remove --purge core20
snap remove --purge core22
snap remove --purge snapd

## Remove Snap APT package
systemctl stop snapd
systemctl disable snapd
systemctl mask snapd
apt-get purge --autoremove snapd -y
apt-mark hold snapd

## Remove Snap directories
rm -rf ~/snap
rm -rf /snap
rm -rf /var/snap
rm -rf /var/lib/snapd

## Prevent Snap installation
cat <<EOF | tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

