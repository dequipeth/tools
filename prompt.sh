!/bin/bash
# Configures terminal prompt theme.
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

  echo $1
  echo $r $g $b
}


fg_black="\[\033[38;2;30m\]"
fg_red="\[\033[38;2;31m\]"
fg_green="\[\033[38;2;32m\]"
fg_yellow="\[\033[38;2;33m\]"
fg_blue="\[\033[38;2;34m\]"
fg_magenta="\[\033[38;2;35m\]"
fg_cyan="\[\033[38;2;36m\]"
fg_white="\[\033[38;2;37m\]"
fg_end="\[\033[00m\]"

line_1="${fg_blue}┌───( \u@\h )-[ \w ]"
line_2="└─\$${fg_end} "

PS1="\r\n${line_1}\r\n${line_2}"
