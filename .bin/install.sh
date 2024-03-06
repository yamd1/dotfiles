#!/bin/bash
set -ue

DOT_DIR=$HOME/dotfiles

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
ln -snf $DOT_DIR/files/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
ln -snf $DOT_DIR/files/.config $HOME

[[ "$USER" == "appuser" ]] && \
    cp $DOT_DIR/files/.config/starship/remote_starship.toml $XDG_CONFIG_HOME/starship.toml || \
    cp $DOT_DIR/files/.config/starship/host_starship.toml $XDG_CONFIG_HOME/starship.toml

ln -snf $DOT_DIR/files/.config/zsh/.zshrc $HOME
ln -snf $DOT_DIR/files/.config/zsh/.zshenv $HOME
ln -snf $DOT_DIR/files/.config/git/.gitconfig $HOME
ln -snf $DOT_DIR/files/.config/.lnav $HOME

$DOT_DIR/.bin/install-aqua.sh

if [[ "${1:-}" == "wsl" ]]; then
  $DOT_DIR/.bin/setup-windows.sh
fi

$(which zsh)
