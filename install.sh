#!/bin/bash
set -ue

DOT_DIR=$HOME/dotfiles

[[ ! -d "$HOME/history" ]] && mkdir -p "$HOME/history"

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
ln -snf $DOT_DIR/files/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
ln -snf $DOT_DIR/files/.config $HOME

if "${IS_CONTAINER:-false}"; then
  echo 'export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/remote_starship.toml"' > $DOT_DIR/files/.config/zsh/.zshenv.local
else
  echo 'export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/host_starship.toml"' > $DOT_DIR/files/.config/zsh/.zshenv.local
fi

ln -snf $DOT_DIR/files/.config/zsh/.zshrc $HOME
ln -snf $DOT_DIR/files/.config/zsh/.zshenv $HOME
ln -snf $DOT_DIR/files/.config/bash/.bash_profile $HOME
ln -snf $DOT_DIR/files/.config/git/.gitconfig $HOME
ln -snf $DOT_DIR/files/.config/.lnav $HOME

$DOT_DIR/.bin/install-aqua.sh

if [[ "${1:-}" == "wsl" ]]; then
  $DOT_DIR/.bin/setup-windows.sh
fi

if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
  while read os; do
    case "$os" in
      debian)
        sudo apt-get update
        sudo apt-get install -y zsh build-essential wl-clipboard
        ;;
      lsb) # Ubuntu
        sudo apt-get update
        sudo apt-get install -y zsh build-essential wl-clipboard
        ;;
      *)
        :
        ;;
    esac
  done < <(\ls /etc/*{release,version} | xargs -I{} basename {} | sed -E 's/(.*)[_-](release|version)/\1/g')
fi
