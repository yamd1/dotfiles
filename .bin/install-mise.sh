#!/bin/bash
set -ue

[[ ! -d $HOME/.local/share/mise/bin ]] && mkdir -p $HOME/.local/share/mise/bin

# avoid use sudo
curl https://mise.jdx.dev/mise-latest-linux-x64 > $HOME/.local/share/mise/bin/mise

$HOME/.local/share/mise/bin/mise install
