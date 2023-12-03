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
  dnf install flatpak -y
  flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
}


## Clean applications
function clean_apps() {
  dnf remove gnome-tour 
  dnf autoremove
}


## Install applications
# https://github.com/GraphiteEditor/Graphite
# https://nickvision.org
##
function install_apps() {

  # System
  flatpak install flathub com.github.tchx84.Flatseal
  flatpak install flathub io.github.flattool.Warehouse
  flatpak install flathub io.github.giantpinkrobots.flatsweep

  # Utilities
  flatpak install flathub org.gnome.clocks
  flatpak install flathub org.gnome.World.Secrets
  flatpak install flathub org.cryptomator.Cryptomator
  flatpak install flathub org.localsend.localsend_app
  flatpak install flathub app.drey.Warp
  flatpak install flathub org.nickvision.money
  flatpak install flathub io.gitlab.news_flash.NewsFlash

  # Tools
  flatpak install flathub org.gnome.Boxes
  flatpak install flathub org.remmina.Remmina
  flatpak install flathub org.filezillaproject.Filezilla
  flatpak install flathub net.cozic.joplin_desktop
  flatpak install flathub org.gnome.meld
  flatpak install flathub org.gaphor.Gaphor

  # Office
  flatpak install flathub org.mozilla.Thunderbird
  flatpak install flathub org.gnome.Evince
  flatpak install flathub org.onlyoffice.desktopeditors

  # Internet
  flatpak install flathub org.chromium.Chromium
  flatpak install flathub com.github.Eloston.UngoogledChromium
  flatpak install flathub com.vivaldi.Vivaldi

  # Messaging
  flatpak install flathub io.github.mimbrero.WhatsAppDesktop
  flatpak install flathub com.discordapp.Discord

  # Multimedia
  flatpak install flathub org.gnome.Loupe
  flatpak install flathub org.gimp.GIMP
  flatpak install flathub org.inkscape.Inkscape
  flatpak install flathub com.spotify.Client
  flatpak install flathub org.nickvision.tagger
  flatpak install flathub org.videolan.VLC
  flatpak install flathub io.mpv.Mpv
  flatpak install flathub fr.handbrake.ghb
  flatpak install flathub com.calibre_ebook.calibre
  flatpak install flathub com.github.johnfactotum.Foliate

  # Development
  flatpak install flathub com.vscodium.codium
}


## Configure Gnome
function configure_gnome() {

  ## Touchpad

  # Enable tap to click
  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

  ## Display

  # Configure scaling
  gsettings set org.gnome.desktop.interface scaling-factor 2
  # Configure night light
  gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
  gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 18
  gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6

  ## Power

  # Disable automatic brightness
  gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
  # Configure suspend
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

}


## Configure theme
# https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
##
configure_theme() {

  # Create themes and icons directories
  mkdir "$HOME/.themes"
  mkdir "$HOME/.icons"

  # Configure dark theme
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  # Configure flatpak theme
  flatpak override --filesystem=$HOME/.themes
  flatpak override --filesystem=$HOME/.icons
  flatpak override --env=GTK_THEME=Adwaita-dark
}


## Configure fractional scaling
function configure_scaling() {
  gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
  gsettings set org.gnome.desktop.interface scaling-factor 1.5
}

