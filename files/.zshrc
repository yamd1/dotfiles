[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dce="docker compose exec -it"
alias avr='task --taskfile /path/to/repo/Taskfile.yml'
eval "$(sheldon source)"

eval "$(starship init zsh)"
