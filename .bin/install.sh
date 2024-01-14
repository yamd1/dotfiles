#!/bin/bash
set -ue

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
ln -snf $HOME/dotfiles/files/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
cp -R $HOME/dotfiles/files/.config $HOME

ln -snf $HOME/dotfiles/files/zsh/.zshrc $HOME
ln -snf $HOME/dotfiles/files/zsh/.zshenv $HOME
ln -snf $HOME/dotfiles/files/git/.gitconfig $HOME
ln -snf $HOME/dotfiles/files/.lnav $HOME

$HOME/dotfiles/.bin/install-aqua.sh

zsh
