[[ -f "$XDG_CONFIG_HOME/zsh/fzf.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/fzf.zsh"
[[ -f "$XDG_CONFIG_HOME/zsh/.zshrc.local" ]] && source "$XDG_CONFIG_HOME/zsh/.zshrc.local"

autoload -Uz add-zsh-hook
autoload -Uz git-branch
autoload -Uz git-reflog
autoload -Uz git-log-preview-rebase
autoload -Uz git-status-pickup-files
autoload -Uz git-emoji-select
autoload -Uz better-edit-command-line
autoload -Uz git-branch-bulk-delete
autoload -Uz gd
autoload -Uz self-insert-with-expand-alias
autoload -Uz send-osc7
autoload -Uz gh-auth-switch-wrapped

alias v="nvim"
alias vim="nvim"
alias devc="devcontainer up --workspace-folder . --dotfiles-repository yamd1/dotfiles --dotfiles-install-command 'install.sh'"
alias de="docker exec -it"
alias ls=" eza -lago --icons"
alias tmp='cd "$(mktemp -d)"'
alias gss="git-status"
alias co="git commit"
alias sw="git switch"
alias rb="git rebase"
alias bd="git-branch-bulk-delete"
alias ghs="gh-auth-switch-wrapped"
alias lg="lazygit"

add-zsh-hook precmd send-osc7

zle -N git-branch
zle -N git-reflog
zle -N git-log-preview-rebase
zle -N git-status-pickup-files
zle -N git-emoji-select
zle -N better-edit-command-line
zle -N self-insert-with-expand-alias

bindkey -e
bindkey '^Gs' git-status-pickup-files
bindkey '^Gm' git-emoji-select
bindkey '^Gb' git-branch
bindkey '^Gr' git-reflog
bindkey '^G^G' git-log-preview-rebase
bindkey '^U' backward-kill-line
bindkey '^[[Z' reverse-menu-complete
bindkey '^O' better-edit-command-line
bindkey ' ' self-insert-with-expand-alias

zstyle ':completion:*' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-packed yes
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} r:|[-_.]=**' '+m:{A-Z}={a-z} r:|[-_.]=**'
zstyle ':completion:*' list-separator '│'
zstyle ':completion:*' list-colors ${(s.:.)${LS_COLORS/no=([^:])#/}} 'no=0;38;5;8' 'ma=0;38;5;0;48;5;8'

HISTFILE=$HOME/history/.zsh_history
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

eval "$(direnv hook zsh)"
[[ -x "$(command -v vivid)" ]] && export LS_COLORS="$(vivid generate ayu)"
[[ ! -x "$(command -v node)" && -x "$(command -v mise)" ]] && eval "$(mise activate zsh)" && eval "$(mise install --log-level warn)"
[[ -x "$(command -v navi)" ]] && eval "$(navi widget zsh)"
[[ -x "$(command -v sheldon)" ]] && eval "$(sheldon source)"
[[ -x "$(command -v starship)" ]] && eval "$(starship init zsh)"
