[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

bindkey \^U backward-kill-line

alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dce="docker compose exec -it"
alias ls="eza -lago --icons"


export LS_COLORS="$(vivid generate molokai)"

zstyle ':completion:*' list-separator '│'
zstyle ':completion:*' list-colors ${(s.:.)${LS_COLORS/no=([^:])#/}} 'no=0;38;5;8' 'ma=0;38;5;0;48;5;8'lias ls="eza -lago --icons"

HISTFILE=$HOME/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
HISTORY_IGNORE='(:|true|false|pwd|which *|type *|where *|exit|(|z)man(| *)|neofetch(| *)|*--help|*--version)'
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
unsetopt BEEP

if [[ -f "$HOME/dotfiles/.zshrc.local" ]]; then
  source "$HOME/dotfiles/.zshrc.local"
fi

if [[ -f "$HOME/.local/bin/rtx" ]]; then
  eval "$($HOME/.local/bin/rtx activate zsh)"
fi

eval "$(navi widget zsh)"
eval "$(sheldon source)"
eval "$(starship init zsh)"
