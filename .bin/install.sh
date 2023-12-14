#!/bin/bash
set -ue

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
cp -fR $HOME/dotfiles/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
cp -fR $HOME/dotfiles/.config $HOME

ln -snf $HOME/dotfiles/.zshrc $HOME
ln -snf $HOME/dotfiles/.zshenv $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME

$HOME/dotfiles/.bin/install-aqua.sh
