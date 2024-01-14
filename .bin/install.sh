#!/bin/bash
set -ue

DOT_DIR=$HOME/dotfiles

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
ln -snf $DOT_DIR/files/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
cp -R $DOT_DIR/files/.config $HOME

ln -snf $DOT_DIR/files/zsh/.zshrc $HOME
ln -snf $DOT_DIR/files/zsh/.zshenv $HOME
ln -snf $DOT_DIR/files/git/.gitconfig $HOME
ln -snf $DOT_DIR/files/.lnav $HOME

$DOT_DIR/.bin/install-aqua.sh

zsh
