#!/bin/bash
set -ue

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
cp -R $HOME/dotfiles/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
cp -R $HOME/dotfiles/.config $HOME

ln -snf $HOME/dotfiles/files/zsh/.zshrc $HOME
ln -snf $HOME/dotfiles/files/zsh/.zshenv $HOME
ln -snf $HOME/dotfiles/files/git/.gitconfig $HOME

$HOME/dotfiles/.bin/install-aqua.sh
