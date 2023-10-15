#!/bin/bash
# Configures terminal prompt theme.
#
# Thomas DEQUIPE


black="30"
red="31"
green="32"
yellow="33"
blue="34"
magenta="35"
cyan="36"
white="37"


PS1='\[\033[01;32m\]┌──${debian_chroot:+($debian_chroot)}(\[\033[00m\]\u@\h\[\033[01;32m\])-[\[\033[01;34m\]\w\[\033[01;32m\]]\n└─\[\033[00m\]\$'

