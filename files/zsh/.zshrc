[[ -f "$HOME/dotfiles/files/zsh/fzf.zsh" ]] && source "$HOME/dotfiles/files/zsh/fzf.zsh"
[[ -f "$HOME/dotfiles/files/zsh/.zshrc.local" ]] && source "$HOME/dotfiles/files/zsh/.zshrc.local"

alias vim="nvim"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dce="docker compose exec -it"
alias ls=" eza -lago --icons"
alias tmp='cd "$(mktemp -d)"'
alias ad="git add -A"
alias co="git commit"
alias sw="git switch"
alias rb="navi --query rb"

[[ -x "$(command -v vivid)" ]] && export LS_COLORS="$(vivid generate ayu)"
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --no-info --no-hscroll --no-sort --no-mouse"

bindkey '^U' backward-kill-line
bindkey '^[[Z' reverse-menu-complete

zstyle ':completion:*' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-packed yes
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} r:|[-_.]=**' '+m:{A-Z}={a-z} r:|[-_.]=**'
zstyle ':completion:*' list-separator '│'
zstyle ':completion:*' list-colors ${(s.:.)${LS_COLORS/no=([^:])#/}} 'no=0;38;5;8' 'ma=0;38;5;0;48;5;8'

HISTFILE=$HOME/.zsh_history
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

[[ ! -x "$(command -v node)" && -x "$(command -v rtx)" ]] && eval "$(rtx activate zsh)" && eval "$(rtx install --log-level warn)"
[[ -x "$(command -v navi)" ]] && eval "$(navi widget zsh)"
[[ -x "$(command -v sheldon)" ]] && eval "$(sheldon source)"
[[ -x "$(command -v starship)" ]] && eval "$(starship init zsh)"
