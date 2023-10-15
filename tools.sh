#!/bin/bash
# This script contains various configuration tools.
#
# Thomas DEQUIPE


###
# Configures Git 
###
git_config() {

	local name="$1"
	local email="$2"

	git config --global user.name "$name"
	git config --global user.email "$email"
}

###
# Downloads the latest release of a GitHub repository 
###
github_download() {

	local user="$1"
	local repository="$2"
	local name="$3"
	local output_dir="$4"
	local tag_name="$(curl -s "https://api.github.com/repos/${user}/${repository}/releases/latest" | sed -n "s|^.*\"tag_name\":.*\"\(.*\)\".*$|\1|p")"

	output="${output_dir}/${name}"

	echo "The latest tag name is $tag_name"
	echo "Downloading $name"

wget -qO "${output_dir}/${name}" "https://github.com/${user}/${repository}/releases/download/${tag_name}/${name}"

	echo "Done"

	return "$output"
}

