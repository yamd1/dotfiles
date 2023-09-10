#!/bin/bash

#----------------------------#
# Install prezto
#----------------------------#
#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

#setopt EXTENDED_GLOB
#for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#done

#----------------------------#
# Install fzf
#----------------------------#
if [ ! -d "~/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

#----------------------------#
# Install commentary
#----------------------------#
if [ ! -d "~/.vim/pack/tpope/start/commentary" ]; then
    mkdir -p ~/.vim/pack/tpope/start
    cd ~/.vim/pack/tpope/start
    git clone https://tpope.io/vim/commentary.git
    vim -u NONE -c "helptags commentary/doc" -c q
fi

#----------------------------#
# Install gitgutter
#----------------------------#
if [ ! -d "~/.vim/pack/airblade/start/vim-gitgutter" ]; then
    mkdir -p ~/.vim/pack/airblade/start
    cd ~/.vim/pack/airblade/start
    git clone https://github.com/airblade/vim-gitgutter.git
    vim -u NONE -c "helptags vim-gitgutter/doc" -c q
fi

#----------------------------#
# Install brew 
#----------------------------#
if [ ! -d "~/../linuxbrew" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.profile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo apt-get install build-essential
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
if [ ! -d "~/.tmux.conf" ]; then 
    ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
fi

#----------------------------#
# WSL 用の調整
#----------------------------#
if [[ "$(uname -r)" == *microsoft* ]]; then
    echo 'Install settings for WSL2'
    # TODO
    echo "以下よりNertFontのダウンロードが必要"
    echo "https://github.com/nvim-tree/nvim-tree.lua#:~:text=nvim%2Dweb%2Ddevicons%20is%20optional%20and%20used%20to%20display%20file%20icons.%20It%20requires%20a%20patched%20font.%20Your%20terminal%20emulator%20must%20be%20configured%20to%20use%20that%20font%2C%20usually%20%22Hack%20Nerd%20Font%22"
fi


#----------------------------#
# 
#----------------------------#
npm install -g @devcontainers/cli

