#!/bin/bash

set -ue

link_to_homedir() {
  command echo "backup old dotfiles..."
  if [[ ! -d "$HOME/.dotbackup" ]];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir=$(dirname ${script_dir})
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      [[ `basename $f` == ".git" ]] && continue
      [[ `basename $f` == ".gitignore" ]] && continue
      if [[ -L "$HOME/`basename $f`" ]];then
        command rm -f "$HOME/`basename $f`"
      fi
      if [[ -e "$HOME/`basename $f`" ]];then
        command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
      fi
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
}

link_to_homedir


if [[ ! -d "$HOME/.local/bin" ]]; then
    mkdir -p $HOME/.local/bin
fi

[[ -e $HOME/.local/bin/starship ]] || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir $HOME/.local/bin

curl -fsSL https://github.com/junegunn/fzf/releases/download/0.43.0/fzf-0.43.0-linux_amd64.tar.gz | tar xz -C $HOME/.local/bin


if [[ ! -e "$HOME/.local/bin/sheldon" ]]; then
  curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
      | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
fi

curl -fsSL https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-gnu.tar.gz | tar xz -C /tmp \
    && mv /tmp/bat-v0.24.0-x86_64-unknown-linux-gnu/bat $HOME/.local/bin

curl -fsSL https://github.com/eza-community/eza/releases/download/v0.15.0/eza_x86_64-unknown-linux-gnu.tar.gz | tar xz -C /tmp \
    && mv /tmp/eza $HOME/.local/bin

YQ_VERSION="v4.40.2"
YQ_BINARY="yq_linux_amd64"
curl -fsSL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz | tar xz -C /tmp \
  && mv /tmp/${YQ_BINARY} $HOME/.local/bin/yq

#---------
# WSL2環境でインストールするときは引数にwsl2をいれる
# unameで判定する方法だと、wsl2上で作動するDockerコンテナ内でもwsl2だと認識するため
#---------
if [[ "$#" = "1" && "$1" = "wsl2" ]]; then
  echo 'Install settings for WSL2'
  curl -fsSL https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz | tar xz -C /tmp \
      && mv /tmp/nvim-linux64/bin/nvim $HOME/.local/bin

  if [[ ! -d "$HOME/.config/rtx" ]]; then
      mkdir -p $HOME/.config/rtx
  fi
  curl -fsSL https://github.com/jdx/rtx/releases/download/v2023.11.0/rtx-v2023.11.0-linux-x64 > $HOME/.local/bin/rtx
  chmod +x $HOME/.local/bin/rtx
  $HOME/.local/bin/rtx use --global node@18

  curl -fsSL https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz | tar xz -C /tmp \
      && mv /tmp/lazygit $HOME/.local/bin

  if [[ ! -e "$HOME/.tmux.conf" ]]; then
      ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
  fi
fi

command echo -e "Install completed!!!!"
