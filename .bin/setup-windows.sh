#!/bin/bash
set -ue

# Symbolic links don't work between WSL2 and Windows, so use cp instead
\ls /mnt/c/Users | fzf | xargs -I_ cp $HOME/dotfiles/files/.config/wezterm/.wezterm.lua /mnt/c/Users/_/.wezterm.lua

if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
  while read os; do
    case "$os" in
      debian)
        sudo apt-get update
        sudo apt-get install -y zsh build-essential ubuntu-wsl wslu unzip
        ;;
      lsb) # Ubuntu
        sudo apt-get update
        sudo apt-get install -y zsh build-essential ubuntu-wsl wslu unzip
        ;;
      *)
        :
        ;;
    esac
  done < <(\ls /etc/*{release,version} | xargs -I{} basename {} | sed -E 's/(.*)[_-](release|version)/\1/g')
fi
