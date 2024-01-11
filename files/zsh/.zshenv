[[ -f "$HOME/dotfiles/files/zsh/.zshenv.local" ]] && source "$HOME/dotfiles/files/zsh/.zshenv.local"

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export AQUA_ROOT_DIR=$HOME/.local/share/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
export AQUA_POLICY_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/policy.yaml
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --no-info --no-scrollbar --no-hscroll --no-sort --no-mouse"

path=(
  "$HOME/bin"(N-/)
  "$HOME/.local/bin"(N-/)
  "$HOME/.local/share"(N-/)
  "$HOME/dotfiles/.bin"(N-/)
  "$AQUA_ROOT_DIR/bin"(N-/)
  "$HOME/.cargo/bin"(N-/)
  "$path[@]"
)

fpath=(
  "$HOME/.local/share/zsh/site-functions"(N-/)
  "$fpath[@]"
)

cdpath=(
  ..
  "$HOME"(N-/)
  "$HOME/develop"(N-/)
  "$HOME/sandobx"(N-/)
  "$HOME/dotfiles"(N-/)
)
