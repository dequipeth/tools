!/bin/bash
# Configures terminal prompt theme.
#
# Thomas DEQUIPE


script_dir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

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
