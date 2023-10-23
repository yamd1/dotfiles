#!/usr/bin/env bash
set -ue

helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

#TODO: シンボリックリンク作成用関数を修正する
link_to_homedir() {
  command echo "backup old dotfiles..."
  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir=$(dirname ${script_dir})
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      [[ `basename $f` == ".git" ]] && continue
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

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir


if [ ! -d "~/.local/bin" ]; then
    mkdir -p $HOME/.local/bin
fi

[[ -e $HOME/.local/bin/starship ]] || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir $HOME/.local/bin

#----------------------------#
# Install fzf
#----------------------------#
curl -fsSL https://github.com/junegunn/fzf/releases/download/0.43.0/fzf-0.43.0-linux_amd64.tar.gz | tar xz -C $HOME/.local/bin

#----------------------------#
# Install commentary
#----------------------------#
if [ ! -d "$HOME/.vim/pack/tpope/start/commentary" ]; then
    mkdir -p $HOME/.vim/pack/tpope/start
    cd $HOME/.vim/pack/tpope/start
    git clone https://tpope.io/vim/commentary.git
    # vim -u NONE -c "helptags commentary/doc" -c q
fi

#----------------------------#
# Install gitgutter
#----------------------------#
if [ ! -d "$HOME/.vim/pack/airblade/start/vim-gitgutter" ]; then
    mkdir -p $HOME/.vim/pack/airblade/start
    cd $HOME/.vim/pack/airblade/start
    git clone https://github.com/airblade/vim-gitgutter.git
    # vim -u NONE -c "helptags vim-gitgutter/doc" -c q
fi

#----------------------------#
# Install brew
#----------------------------#
# brew install nvim

#----------------------------#
# Install lazygit
#----------------------------#
# brew install lazygit

#----------------------------#
# Install tmux
#----------------------------#
# brew install tmux
# if [ ! -e "$HOME/.tmux.conf" ]; then
#     ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
# fi


#----------------------------#
#  Install Sheldon
#  SEE: https://sheldon.cli.rs/Introduction.html
#----------------------------#

if [ ! -e "$HOME/.local/bin/sheldon" ]; then
  curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
      | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
fi

command echo -e "Install completed!!!!"
