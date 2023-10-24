#!/bin/bash
# Configures bash terminal prompt theme.
#
# https://github.com/gcholette/bash-ps1-themes
# https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-bash-ps1-prompt
#
# Thomas DEQUIPE


script_dir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
. "$script_dir/tools.sh"
. "$script_dir/colors.sh"


line_1="${light_blue_fg}┌───${grey_fg} \u@\h ${light_blue_fg}──${grey_fg} \w ${light_blue_fg}"
line_2="└─ \$${no_color} "

PS1="\r\n${line_1}\r\n${line_2}"
