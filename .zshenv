path=(
  "$HOME/bin"(N-/)
  "$HOME/.local/bin"(N-/)
  "$HOME/.local/share"(N-/)
  "$HOME/dotfiles/.bin"(N-/)
  "$path[@]"
)

fpath=(
  "$HOME/.local/share/zsh/site-functions"(N-/)
  "$fpath[@]"
)

[[ -f "$HOME/dotfiles/.zshenv.local" ]] && source "$HOME/dotfiles/.zshenv.local"
