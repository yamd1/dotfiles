#!/bin/bash
set -ue

DOT_DIR=$HOME/dotfiles

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
ln -snf $DOT_DIR/files/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
ln -snf $DOT_DIR/files/.config $HOME

ln -snf $DOT_DIR/files/.config/zsh/.zshrc $HOME
ln -snf $DOT_DIR/files/.config/zsh/.zshenv $HOME
ln -snf $DOT_DIR/files/.config/git/.gitconfig $HOME
ln -snf $DOT_DIR/files/.config/.lnav $HOME

$DOT_DIR/.bin/install-aqua.sh

if [[ "${1:-}" == "wsl" ]]; then
  # Symbolic links don't work between WSL2 and Windows, so use cp instead
  \ls /mnt/c/Users | fzf | xargs -I_ cp $DOT_DIR/files/.config/wezterm/.wezterm.lua /mnt/c/Users/_/.wezterm.lua
fi

$(which zsh)
