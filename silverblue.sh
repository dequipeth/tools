#!/bin/bash
# This script performs the post-installation tasks of Fedora Silverblue.
# It must be executed as root.
#
# https://github.com/polkaulfield/ubuntu-debullshit
#
# Thomas DEQUIPE


### Variables
SCRIPT_DIR="$(dirname "$0")"
ICONS_DIR="$HOME/.icons"

HOSTNAME="$1"
USERNAME="$2"


### Edit GRUB configuration
# For the Framework Laptop
# https://github.com/FrameworkComputer/linux-docs/blob/main/Fedora38-11thGen.md
###
edit_grub() {
	rpm-ostree kargs --append=nvme.noacpi=1
}

### Set hostname
set_hostname() {
	hostnamectl set-hostname $HOSTNAME
}

### Upgrade packages
upgrade_packages() {
	rpm-ostree upgrade
}

### Enable RPM Fusion repository
enable_rpm_fusion() {
	rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

### Configure aliases
configure_aliases() {
	mkdir .bashrc.d
	echo 'alias ll="ls -lh"' > ~/.bashrc.d/aliases
	echo 'alias la="ls -lah"' >> ~/.bashrc.d/aliases
	echo 'alias clear-history="rm -f ~/.bash_history"' >> ~/.bashrc.d/aliases
	echo 'alias firefox-esr="~/.applications/firefox/firefox &"' >> ~/.bashrc.d/aliases
}

### Configure environment variables
configure_variables() {
	echo "export MOZ_ENABLE_WAYLAND=1" > ~/.bashrc.d/variables
}

### Configure GNOME
# https://github.com/GNOME/gsettings-desktop-schemas/tree/master/schemas
###
configure_gnome() {
	# Enable fractional scaling
	gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
	# Configure scaling factor
	gsettings set org.gnome.desktop.interface scaling-factor 1.25
	# Disable automatic screen brightness
	gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
	# Enable dark theme
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	# Configure touchpad
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
	# Configure toolbar icon size	
	gsettings set org.gnome.desktop.interface toolbar-icons-size 'small'
	# Enable battery percentage
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	# Disable location
	gsettings set org.gnome.system.location enabled false

	# Configure locale
	gsettings set org.gnome.system.locale region 'fr_FR.UTF-8'
	localectl set-locale LANG=fr_FR.UTF-8

	# Configure the cursor theme
	gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
}

### Configure themes
# https://github.com/lassekongo83/adw-gtk3/
###
configure_themes() {

	wget https://github.com/lassekongo83/adw-gtk3/releases/download/v4.8/adw-gtk3v4-8.tar.xz -O /tmp/adw-gtk3.tar.xz
	tar -xvf /tmp/adw-gtk3.tar.xz -C /usr/share/themes
	rm -f /tmp/adw-gtk3.tar.xz

	curl -s "https://github.com/lassekongo83/adw-gtk3/releases/latest"

	flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y

	if [ "$(gsettings get org.gnome.desktop.interface color-scheme)" == "'prefer-dark'" ]; then
		gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
		gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	else
		gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3
	fi
}


### Configure Firefox
# https://kb.mozillazine.org/User.js_file
# https://github.com/dannycolin/dotfiles
# https://github.com/mozilla/policy-templates/blob/v5.0/docs/index.md
# https://github.com/pyllyukko/user.js/
# https://github.com/arkenfox/user.js/
###
configure_firefox() {

	cp "$script_dir/firefox/policies.json"  /etc/firefox/policies/policies.json

	firefox_path="~/.mozilla/firefox"

	# Create profile
	firefox -createProfile "$username"
	profile_name="$(ls | grep $username)"
	profile_path="$firefox_path/$profile_name"
	install_name="$(sed -n "s/^\[\(.*\)\]$/\1/p" ~/.mozilla/firefox/installs.ini)"

	# Set default profile
	cat << EOF > "$firefox_path/profiles.ini"
[Profile0]
Name=$username
IsRelative=1
Path=$profile_name

[General]
StartWithLastProfile=1
Version=2

[Install$install_name]
Default=$profile_name
Locked=1
EOF

	cat << EOF > "$firefox_path/installs.ini"
[$install_name]
Default=$profile_name
Locked=1
EOF

	find "$firefox_path" -type d -maxdepth 1 -regex ".*default.*" -exec rm -r {} \; 2> /dev/null

	# Import preferences
	cp "$script_dir/firefox/user.js" "$firefox_path/$profile_name/user.js"
	mkdir "$firefox_path/$profile_name/chrome"
	cp "$script_dir/firefox/userContent.css" "$firefox_path/$profile_name/chrome/userContent.css"
}

### Install media codecs
# https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/
###
install_media_codecs() {
	rpm-ostree install gstreamer1-plugins-{base,good,good-\*,bad-\*,ugly,ugly-\*} gstreamer1-plugin-openh264 gstreamer1-libav --allow-inactive
	rpm-ostree install lame\* --allow-inactive
	rpm-ostree upgrade
}


### Install Obsidian
install_obsidian() {
	flatpak install flathub md.obsidian.Obsidian
	flatpak override --env OBSIDIAN_USE_WAYLAND=1 md.obsidian.Obsidian
}

