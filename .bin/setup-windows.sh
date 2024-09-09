#!/bin/bash
set -ue

# Symbolic links don't work between WSL2 and Windows, so use cp instead
\ls /mnt/c/Users | fzf | xargs -I_ cp $HOME/dotfiles/files/.config/wezterm/.wezterm.lua /mnt/c/Users/_/.wezterm.lua

sudo apt-get update

sudo apt-get install -y wl-clipboard ubuntu-wsl wslu unzip
