#!/bin/bash
# Tools for bash terminal prompt theme.
#
# https://github.com/gcholette/bash-ps1-themes
#
# Thomas DEQUIPE

function current_user() {
  if [ -n "$USER" ]; then
    printf "$USER"
  else
    printf "$USERNAME"
  fi
}

long_datetime() {
  printf "$(date "+%A %d %B %Y %T")"
}

short_datetime() {
  printf "$(date "+%a %d %b %T")"
}

long_date() {
  printf "$(date "+%A %d %B")"
}

short_date() {
  printf "$(date "+%a %d %b")"
}

short_time() {
  printf "$(date "+%T")"
}
