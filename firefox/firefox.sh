#!/bin/bash
# This script installs firefox on Ubuntu.
#
# It must be executed as root.
#
# Thomas DEQUIPE


wget https://packages.mozilla.org/apt/repo-signing-key.gpg -O /etc/apt/keyrings/packages.mozilla.org.asc
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" > /etc/apt/sources.list.d/mozilla.list

apt update
apt install firefox

