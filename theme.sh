#!/bin/bash
# This script installs custom theme and icons.
#
# Thomas DEQUIPE


### Variables
SCRIPT_DIR="$(dirname "$0")"
ICONS_DIR="$HOME/.icons"

mkdir -p "$ICONS_DIR"


### Install Bibata cursor icons
# https://github.com/ful1e5/Bibata_Cursor
# https://wiki.archlinux.org/title/Cursor_themes
###
install_bibata() {

	local themes="Bibata-Original-Classic Bibata-Modern-Classic Bibata-Original-Ice Bibata-Modern-Ice"
	local input_theme="$1"
	local theme="Bibata-Original-Classic"

	local temp_file="$(mktemp)"
	local temp_dir="$(mktemp -d)"

	local tag_name="$(curl -s "https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest" | sed -n "s|^.*\"tag_name\":.*\"\(.*\)\".*$|\1|p")"
	echo "The latest tag is $tag_name"

	echo "Downloading theme"
	wget -qO "$temp_file" \
		"https://github.com/ful1e5/Bibata_Cursor/releases/download/${tag_name}/Bibata.tar.xz"
	echo "Done"

	echo "Extracting archive"
	tar -xf "${temp_dir}/Bibata.tar.xz" -C "$temp_dir"
	mv "${temp_dir}/Bibata-*" "$ICONS_DIR"
	echo "Done"

	for t in $themes; do
		if [[ "$t" == "$input_theme" ]]; then
			theme="$t"
			break
		fi
	done
	echo "Setting $theme theme"
	gsettings set org.gnome.desktop.interface cursor-theme "$theme"
	echo "Done"

	echo "Removing temporary files"
	rm -rf "$temp_dir"
	rm -f "$temp_file"
	echo "Done"
}


### Install Papirus icons
# https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
###
install_papirus() {

	local temp_file="$(mktemp)"
	local temp_dir="$(mktemp -d)"

	echo "Downloading icons theme"
  wget -qO "$temp_file" \
		"https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/master.tar.gz"

  echo "Extracting archive"
  tar -xzf "$temp_file" -C "$temp_dir"

	if [[ -d "${temp_dir}/${repository}-${tag}/${theme}" ]]; then
		echo "Installing icons theme"
		
	fi

	gsettings set org.gnome.desktop.interface icon-theme papirus

	echo "Removing temporary files"
	rm -f "$temp_file"
	rm -rf "$temp_dir"
	echo "Done"
}

