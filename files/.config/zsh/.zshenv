export DOT_DIR=$HOME/dotfiles
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export AQUA_ROOT_DIR=$HOME/.local/share/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
export AQUA_POLICY_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/policy.yaml
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --no-info --no-scrollbar --no-hscroll --no-sort --no-mouse"
export DEVC_COMPOSE_OVERRIDE=$XDG_CONFIG_HOME/devcontainer/compose.override.yml
export EDITOR=nvim
export GH_BROWSER=$HOME/.local/bin/open
export SHELL=/usr/bin/zsh

path=(
  "$HOME/bin"(N-/)
  "$DOT_DIR/.bin"(N-/)
  "$AQUA_ROOT_DIR/bin"(N-/)
  "$HOME/.local/share/mise/shims"(N-/)
  "$HOME/.local/bin"(N-/)
  "$HOME/.local/share"(N-/)
  "$HOME/.cargo/bin"(N-/)
  "$HOME/.local/share/zsh/site-functions"(N-/)
  "$path[@]"
)

fpath=(
  "$HOME/.local/share/zsh/site-functions"(N-/)
  "$HOME/.local/share/zsh/functions"(N-/)
  "$fpath[@]"
)

cdpath=(
  ..
  "$HOME"(N-/)
  "$DOT_DIR"(N-/)
  "$cdpath[@]"
)

[[ -f "$XDG_CONFIG_HOME/zsh/.zshenv.local" ]] && source "$XDG_CONFIG_HOME/zsh/.zshenv.local"
[[ -e "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
