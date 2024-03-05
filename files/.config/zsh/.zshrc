[[ -f "$XDG_CONFIG_HOME/zsh/fzf.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/fzf.zsh"
[[ -f "$XDG_CONFIG_HOME/zsh/.zshrc.local" ]] && source "$XDG_CONFIG_HOME/zsh/.zshrc.local"

autoload -Uz git-branch
autoload -Uz git-reflog
autoload -Uz git-log-preview-rebase
autoload -Uz git-status

alias v="nvim.sh"
alias vim="nvim.sh"
alias devc="devcontainer up --working-dir ."
alias de="docker exec -it"
alias ls=" eza -lago --icons"
alias tmp='cd "$(mktemp -d)"'
alias ad="git add -A"
alias co="git commit"
alias sw="git switch"
alias rb="git rebase"
alias bd="git-branch-bulk-delete"
alias nrb="navi --query rb"
alias e="explorer.exe"

zle -N git-branch
zle -N git-reflog
zle -N git-log-preview-rebase
zle -N git-status

bindkey '^G^B' git-branch
bindkey '^G^G' git-log-preview-rebase
bindkey '^G^R' git-reflog
bindkey '^U' backward-kill-line
bindkey '^[[Z' reverse-menu-complete
bindkey '^G^T' git-status

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

[[ -x "$(command -v vivid)" ]] && export LS_COLORS="$(vivid generate ayu)"
[[ ! -x "$(command -v node)" && -x "$(command -v rtx)" ]] && eval "$(rtx activate zsh)" && eval "$(rtx install --log-level warn)"
[[ -x "$(command -v navi)" ]] && eval "$(navi widget zsh)"
[[ -x "$(command -v sheldon)" ]] && eval "$(sheldon source)"
[[ -x "$(command -v starship)" ]] && eval "$(starship init zsh)"
