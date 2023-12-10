[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
[[ -f "$HOME/dotfiles/.zshrc.local" ]] && source "$HOME/dotfiles/.zshrc.local"
[[ -f "$HOME/.local/bin/rtx" ]] && eval "$($HOME/.local/bin/rtx activate zsh)"

alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dce="docker compose exec -it"
alias ls="eza -lago --icons"
alias tmp='cd "$(mktemp -d)"'

export LS_COLORS="$(vivid generate ayu)"
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --no-info --no-hscroll --no-sort --no-mouse"

bindkey \^U backward-kill-line
zstyle ':completion:*' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-packed yes
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} r:|[-_.]=**' '+m:{A-Z}={a-z} r:|[-_.]=**'
zstyle ':completion:*' list-separator '│'
zstyle ':completion:*' list-colors ${(s.:.)${LS_COLORS/no=([^:])#/}} 'no=0;38;5;8' 'ma=0;38;5;0;48;5;8'

HISTFILE=$HOME/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
HISTORY_IGNORE='(:|true|false|pwd|which *|type *|where *|exit|(|z)man(| *)|neofetch(| *)|*--help|*--version)'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=black,bold"

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
unsetopt BEEP

eval "$(navi widget zsh)"
eval "$(sheldon source)"
eval "$(starship init zsh)"
