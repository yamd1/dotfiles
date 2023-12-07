export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/share:/usr/local/bin:$PATH
export PATH=$HOME/dotfiles/.bin:/usr/local/bin:$PATH
export FPATH=$HOME/.local/share/zsh/site-functions:$FPATH
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups

if [[ -f "$HOME/dotfiles/.zshenv.local" ]]; then
  source "$HOME/dotfiles/.zshenv.local"
fi
