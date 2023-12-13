#!/bin/bash
set -ue

cp -R $HOME/dotfiles/.local $HOME
ln -snf $HOME/dotfiles/.config $HOME
ln -snf $HOME/dotfiles/.zshrc $HOME
ln -snf $HOME/dotfiles/.zshenv $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME

$HOME/dotfiles/.bin/install-aqua.sh
