[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dce="docker compose exec -it"
alias ls="eza -lago --icons"

if [[ -f "$HOME/dotfiles/.zshrc.local" ]]; then
  source "$HOME/dotfiles/.zshrc.local"
fi

eval "$($HOME/.local/bin/rtx activate zsh)"

eval "$(sheldon source)"

eval "$(starship init zsh)"
