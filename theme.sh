#!/bin/bash
# This script installs custom theme and icons.
#
# Thomas DEQUIPE


### Variables
ICONS_DIR="$HOME/.icons"

mkdir -p "$ICONS_DIR"


### Install Bibata cursor icons
# https://github.com/ful1e5/Bibata_Cursor
# https://wiki.archlinux.org/title/Cursor_themes
###
install_bibata() {

	BIBATA_VERSION="$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest | sed -n "s|^.*\"tag_name\": \"\(.*\)\",$|\1|p")"

	wget -qO "$ICONS_DIR/Bibata-Original-Classic.tar.xz" "https://github.com/ful1e5/Bibata_Cursor/releases/download/$BIBATA_VERSION/Bibata-Original-Classic.tar.xz"
	tar -xf "$ICONS_DIR/Bibata-Original-Classic.tar.xz" -C "$ICONS_DIR"
	rm -f "$ICONS_DIR/Bibata-Original-Classic.tar.xz"
	mv "$ICONS_DIR/Bibata-Original-Classic" "$ICONS_DIR/bibata-original-classic"

	gsettings set org.gnome.desktop.interface cursor-theme bibata-original-classic
	gsettings set org.gnome.desktop.interface cursor-size 24
}


### Install Papirus icons
# https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
###
install_papirus() {

	wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

	gsettings set org.gnome.desktop.interface icon-theme papirus
}

