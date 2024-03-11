export DOT_DIR=$HOME/dotfiles
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export AQUA_ROOT_DIR=$HOME/.local/share/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
export AQUA_POLICY_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/policy.yaml
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --no-info --no-scrollbar --no-hscroll --no-sort --no-mouse"
export DEVC_COMPOSE_OVERRIDE=$XDG_CONFIG_HOME/devcontainer/compose.override.yml
export LC_CTYPE=ja_JP.UTF-8
export EDITOR=nvim

path=(
  "$HOME/bin"(N-/)
  "$HOME/.local/bin"(N-/)
  "$HOME/.local/share"(N-/)
  "$DOT_DIR/.bin"(N-/)
  "$AQUA_ROOT_DIR/bin"(N-/)
  "$HOME/.cargo/bin"(N-/)
  "$HOME/.local/share/zsh/site-functions"(N-/)
  "$path[@]"
)

fpath=(
  "$HOME/.local/share/zsh/site-functions"(N-/)
  "$DOT_DIR/.bin"(N-/)
  "$fpath[@]"
)

cdpath=(
  ..
  "$HOME"(N-/)
  "$DOT_DIR"(N-/)
  "$cdpath[@]"
)

[[ -f "$XDG_CONFIG_HOME/zsh/.zshenv.local" ]] && source "$XDG_CONFIG_HOME/zsh/.zshenv.local"
