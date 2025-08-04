#!/bin/bash
set -ue

# This script is WSL-specific and should not run on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "This script is for WSL only. Skipping on macOS."
    exit 0
fi

# Symbolic links don't work between WSL2 and Windows, so use cp instead
\ls /mnt/c/Users | fzf | xargs -I_ cp $HOME/dotfiles/files/.config/wezterm/.wezterm.lua /mnt/c/Users/_/.wezterm.lua
