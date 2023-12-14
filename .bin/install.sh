#!/bin/bash
set -ue

cp -fR $HOME/dotfiles/.local $HOME
cp -fR $HOME/dotfiles/.config $HOME
ln -snf $HOME/dotfiles/.zshrc $HOME
ln -snf $HOME/dotfiles/.zshenv $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME
ln -snf $HOME/dotfiles/.gitconfig $HOME

$HOME/dotfiles/.bin/install-aqua.sh
