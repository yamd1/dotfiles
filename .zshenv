export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/dotfiles/.bin:/usr/local/bin:$PATH

if [ -e "$HOME/dotfiles/.zshenv.local" ]; then
  source "$HOME/dotfiles/.zshenv.local"
fi
