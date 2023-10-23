#!/bin/bash

if [ ! -d "~/.local/bin" ]; then
    mkdir -p $HOME/.local/bin
fi

[[ -e $HOME/.local/bin/starship ]] || curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir $HOME/.local/bin


#----------------------------#
# Install fzf
#----------------------------#
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
fi

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
rm -rf $HOME/../linuxbrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get update && sudo apt-get install build-essential
brew install gcc

#----------------------------#
# Install brew
#----------------------------#
brew install nvim

#----------------------------#
# Install lazygit
#----------------------------#
brew install lazygit

#----------------------------#
# Install tmux
#----------------------------#
brew install tmux
if [ ! -e "$HOME/.tmux.conf" ]; then
    ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
fi


#----------------------------#
#  Install Sheldon
#  SEE: https://sheldon.cli.rs/Introduction.html
#----------------------------#
brew install sheldon
