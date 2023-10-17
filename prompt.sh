#!/bin/bash
# Configures terminal prompt theme.
#
# https://github.com/gcholette/bash-ps1-themes
# https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-bash-ps1-prompt
#
# Thomas DEQUIPE


script_dir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")


hex_to_rgb() {

  hex="$(echo "$1" | sed 's/#//g')"

  r="$(echo "$hex" | cut -c-2)"
  g="$(echo "$hex" | cut -c3-4)"
  b="$(echo "$hex" | cut -c5-6)"

  r="$(echo "ibase=16; $r" | bc)"
  g="$(echo "ibase=16; $g" | bc)"
  b="$(echo "ibase=16; $b" | bc)"

  printf "%d;%d;%d\n" "$r" "$g" "$b"
}

rgb_fg() {
  printf "\[\033[38;2;$(hex_to_rgb "$1")m\]"
}

rgb_bg() {
  printf "\[\033[48;2;$(hex_to_rgb "$1")m\]"
}

	
black_fg="$(rgb_fg "#000000")"

red_fg="$(rgb_fg "#FF0000")"
dark_red_fg="$(rgb_fg "#AF0000")"
darker_red_fg="$(rgb_fg "#910000")"

green_fg="$(rgb_fg "#00FF00")"
dark_green_fg="$(rgb_fg "#00AF00")"
darker_green_fg="$(rgb_fg "#009100")"

blue_fg="$(rgb_fg "#0000FF")"
dark_blue_fg="$(rgb_fg "#0000AF")"
darker_blue_fg="$(rgb_fg "#000091")"

yellow_fg="$(rgb_fg "#FFFF00")"
dark_yellow_fg="$(rgb_fg "#AFAF00")"
darker_yellow_fg="$(rgb_fg "#919100")"

magenta_fg="$(rgb_fg "#FF00FF")"
dark_magenta_fg="$(rgb_fg "#AF00AF")"
darker_magenta_fg="$(rgb_fg "#910091")"

cyan_fg="$(rgb_fg "#00FFFF")"
dark_cyan_fg="$(rgb_fg "#00AFAF")"
darker_cyan_fg="$(rgb_fg "#009191")"

grey_fg="$(rgb_fg "#C8C8C8")"
dark_grey_fg="$(rgb_fg "#AFAFAF")"
darker_grey_fg="$(rgb_fg "#919191")"

white_fg="$(rgb_fg "#FFFFFF")"

light_blue_fg="$(rgb_fg "#005AFF")"

no_color="\[\033[0m\]"

bold="$(tput bold)"
normal="$(tput sgr0)"


line_1="${light_blue_fg}┌───${grey_fg} \u@\h ${light_blue_fg}──${grey_fg} \w ${light_blue_fg}"
line_2="└─ \$${no_color} "

PS1="\r\n${line_1}\r\n${line_2}"
