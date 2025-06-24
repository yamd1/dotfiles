export DOTDIR=$HOME/dotfiles
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export AQUA_ROOT_DIR=$HOME/.local/share/aquaproj-aqua
export AQUA_GLOBAL_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
export AQUA_POLICY_CONFIG=$XDG_CONFIG_HOME/aquaproj-aqua/policy.yaml
export FZF_DEFAULT_OPTS="--reverse --cycle --ansi --no-info --no-scrollbar --no-hscroll --no-sort --no-mouse"
export DEVC_COMPOSE_OVERRIDE=$XDG_CONFIG_HOME/devcontainer/compose.override.yml
export EDITOR=nvim
export GH_BROWSER=xdg-open
export SHELL=/usr/bin/zsh
export DIRENV_WARN_TIMEOUT=100s
export STARSHIP_CONFIG=${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship/host_starship.toml}

path=(
  $HOME/bin(N-/)
  $DOTDIR/.bin(N-/)
  $AQUA_ROOT_DIR/bin(N-/)
  $HOME/.local/share/mise/shims(N-/)
  $HOME/.local/bin(N-/)
  $HOME/.local/share(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.local/share/zsh/site-functions(N-/)
  # Homebrew paths for macOS
  /opt/homebrew/bin(N-/)
  /usr/local/bin(N-/)
  $path
)

fpath=(
  $HOME/.local/share/zsh/site-functions(N-/)
  $HOME/.local/share/zsh/functions(N-/)
  $fpath
)

cdpath=(
  ..
  $HOME(N-/)
  $DOTDIR(N-/)
  $cdpath
)

[[ -f "$XDG_CONFIG_HOME/zsh/.zshenv.local" ]] && source "$XDG_CONFIG_HOME/zsh/.zshenv.local"
[[ -e "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
