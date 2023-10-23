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
if [ ! -d "$HOME/../linuxbrew" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.profile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo apt-get update && sudo apt-get install build-essential
    brew install gcc
fi

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

#----------------------------#
# WSL 用の調整
#----------------------------#
if [[ "$(uname -r)" == *microsoft* ]]; then
    echo 'Install settings for WSL2'
    # TODO
    echo "以下よりNertFontのダウンロードが必要"
    echo "https://github.com/nvim-tree/nvim-tree.lua#:~:text=nvim%2Dweb%2Ddevicons%20is%20optional%20and%20used%20to%20display%20file%20icons.%20It%20requires%20a%20patched%20font.%20Your%20terminal%20emulator%20must%20be%20configured%20to%20use%20that%20font%2C%20usually%20%22Hack%20Nerd%20Font%22"
fi
