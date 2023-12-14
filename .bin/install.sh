#!/bin/bash
set -ue

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
cp -R $HOME/dotfiles/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
cp -R $HOME/dotfiles/.config $HOME

ln -snf $HOME/dotfiles/.zshrc $HOME
ln -snf $HOME/dotfiles/.zshenv $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME

$HOME/dotfiles/.bin/install-aqua.sh
