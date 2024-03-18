#!/bin/bash
set -ue

DOT_DIR=$HOME/dotfiles

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
ln -snf $DOT_DIR/files/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
ln -snf $DOT_DIR/files/.config $HOME

if "${IS_CONTAINER:-false}"; then
  cp $DOT_DIR/files/.config/starship/remote_starship.toml $HOME/.config/starship.toml
else
  cp $DOT_DIR/files/.config/starship/host_starship.toml $HOME/.config/starship.toml
fi

ln -snf $DOT_DIR/files/.config/zsh/.zshrc $HOME
ln -snf $DOT_DIR/files/.config/zsh/.zshenv $HOME
ln -snf $DOT_DIR/files/.config/git/.gitconfig $HOME
ln -snf $DOT_DIR/files/.config/.lnav $HOME

$DOT_DIR/.bin/install-aqua.sh

if [[ "${1:-}" == "wsl" ]]; then
  $DOT_DIR/.bin/setup-windows.sh
fi

if [[ -n "$WAYLAND_DISPLAY" ]]; then
  while read os; do
    case "$os" in
      debian)
        sudo apt-get update
        sudo apt-get install -y wl-clipboard
        ;;
      lsb) # Ubuntu
        sudo apt-get update
        sudo apt-get install -y wl-clipboard
        ;;
      *)
        :
        ;;
    esac
  done < <(ls /etc/*release | grep -o '\/.*[_-]release' | sed "s/\/etc\/\(.*\)[_-]release/\1/g")
fi
