alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dce="docker compose exec -it"
alias dvd="devcontainer down"
alias dvu="devcontainer up --workspace-folder"
alias dve="devcontainer exec --workspace-folder"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/dotfiles/.bin:/usr/local/bin:$PATH

if [ ! -e "$HOME/dotfiles/.zshenv.local" ]; then
  source "$HOME/dotfiles/.zshenv.local"
fi


