export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export AQUA_ROOT_DIR=$HOME/.local/share/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
export AQUA_POLICY_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/policy.yaml

path=(
  "$HOME/bin"(N-/)
  "$HOME/.local/bin"(N-/)
  "$HOME/.local/share"(N-/)
  "$HOME/dotfiles/.bin"(N-/)
  "$AQUA_ROOT_DIR/bin"(N-/)
  "$path[@]"
)

fpath=(
  "$HOME/.local/share/zsh/site-functions"(N-/)
  "$fpath[@]"
)

[[ -f "$HOME/dotfiles/.zshenv.local" ]] && source "$HOME/dotfiles/.zshenv.local"
