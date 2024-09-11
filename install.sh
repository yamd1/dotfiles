#!/bin/bash
set -ue

DOT_DIR=$HOME/dotfiles

[[ ! -d "$HOME/.docker_history" ]] && mkdir -p "$HOME/.docker_history"

[[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
ln -snf $DOT_DIR/files/.local $HOME

[[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
ln -snf $DOT_DIR/files/.config $HOME

# Since environment variables cannot be used in the service definition file, embed the path to the program to be run as a daemon in the install script.
[[ ! -d "$HOME/.donfig/systemd/user" ]] && mkdir -p "$HOME/.config/systemd/user"
cat <<EOF > $HOME/.config/systemd/user/BrowserPipe.service
[Unit]
Description = demonize named pipe to xdg-open
After=local-fs.target
ConditionPathExists=$HOME/.local/bin

[Service]
ExecStart=$HOME/.local/bin/browser-pipe-handler
Restart=no
Type=simple

[Install]
WantedBy=default.target
EOF

if "${IS_CONTAINER:-false}"; then
  echo 'export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/remote_starship.toml"' > $DOT_DIR/files/.config/zsh/.zshenv.local
else
  echo 'export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/host_starship.toml"' > $DOT_DIR/files/.config/zsh/.zshenv.local
fi

ln -snf $DOT_DIR/files/.config/zsh/.zshrc $HOME
ln -snf $DOT_DIR/files/.config/zsh/.zshenv $HOME
ln -snf $DOT_DIR/files/.config/bash/.bash_profile $HOME
ln -snf $DOT_DIR/files/.config/git/.gitconfig $HOME
ln -snf $DOT_DIR/files/.config/.lnav $HOME

$DOT_DIR/.bin/install-aqua.sh
$DOT_DIR/.bin/install-mise.sh

if [[ "${1:-}" == "wsl" ]]; then
  $DOT_DIR/.bin/setup-windows.sh
  systemctl --user daemon-reload
  systemctl --user enable BrowserPipe
  systemctl --user start BrowserPipe
fi
