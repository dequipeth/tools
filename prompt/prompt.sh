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


BLUE="$(tput setaf 32)"
GREY="$(tput setaf 247)"
BOLD="$(tput bold)"
RESET="$(tput sgr0)"


LINE_1="${BOLD}${BLUE}┌───${GREY} \u@\h ${BLUE}──${GREY} \w"
LINE_2="${BLUE}│${GREY} $(short_datetime)"
LINE_3="${BLUE}└─ \$${RESET} "

PS1="\r\n${LINE_1}\r\n${LINE_2}\r\n${LINE_3}"
