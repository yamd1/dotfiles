#!/bin/bash
set -ue

DOT_DIR=$HOME/dotfiles

# OS detection
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    else
        echo "Unsupported OS: $OSTYPE"
        exit 1
    fi
}

# Create necessary directories
setup_directories() {
    echo "Setting up directories..."
    [[ ! -d "$HOME/.local/state/zsh" ]] && mkdir -p "$HOME/.local/state/zsh"
    [[ ! -d "$HOME/.devcontainer_history" ]] && mkdir -p "$HOME/.devcontainer_history"
    [[ ! -x "$HOME/.devcontainer_history/history" ]] && touch "$HOME/.devcontainer_history/history"
}

# Setup symbolic links
setup_symlinks() {
    echo "Setting up symbolic links..."
    [[ -d "$HOME/.local" ]] && rm -rf "$HOME/.local"
    ln -snf $DOT_DIR/files/.local $HOME

    [[ -d "$HOME/.config" ]] && rm -rf "$HOME/.config"
    ln -snf $DOT_DIR/files/.config $HOME

    ln -snf $DOT_DIR/files/.config/zsh/.zshrc $HOME
    ln -snf $DOT_DIR/files/.config/zsh/.zshenv $HOME
    ln -snf $DOT_DIR/files/.config/bash/.bash_profile $HOME
    ln -snf $DOT_DIR/files/.config/git/.gitconfig $HOME
    ln -snf $DOT_DIR/files/.config/.lnav $HOME
}

# Setup starship configuration
setup_starship() {
    echo "Setting up Starship configuration..."
    if "${IS_CONTAINER:-false}"; then
        echo 'export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/remote_starship.toml"' > $DOT_DIR/files/.config/zsh/.zshenv.local
    else
        echo 'export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/host_starship.toml"' > $DOT_DIR/files/.config/zsh/.zshenv.local
    fi
}

# Install tools
install_tools() {
    echo "Installing tools..."
    $DOT_DIR/.bin/install-aqua.sh
    $DOT_DIR/.bin/install-mise.sh
}

ln -snf $DOT_DIR/files/.config/zsh/.zshrc $HOME
ln -snf $DOT_DIR/files/.config/zsh/.zshenv $HOME
ln -snf $DOT_DIR/files/.config/bash/.bash_profile $HOME
ln -snf $DOT_DIR/files/.config/git/.gitconfig $HOME
ln -snf $DOT_DIR/files/.config/.lnav $HOME
ln -snf $DOT_DIR/files/.config/.claude $HOME

# Install packages for Linux
install_linux_packages() {
    echo "Installing Linux packages..."
    sudo apt-get update
    sudo apt-get install -y zsh build-essential unzip xdg-utils
    xdg-settings set default-web-browser file-protocol-handler.desktop
}

# Install packages for macOS
install_macos_packages() {
    echo "Installing macOS packages..."
    # Check if Homebrew is installed (check both PATH and standard locations)
    BREW_CMD=""
    if command -v brew &> /dev/null; then
        BREW_CMD="brew"
    elif [[ -x "/opt/homebrew/bin/brew" ]]; then
        BREW_CMD="/opt/homebrew/bin/brew"
    elif [[ -x "/usr/local/bin/brew" ]]; then
        BREW_CMD="/usr/local/bin/brew"
    fi
    
    if [[ -z "$BREW_CMD" ]]; then
        echo "Homebrew is not installed. Installing Homebrew..."
        echo "This may require your password for sudo access."
        echo "Press Enter to continue or Ctrl+C to cancel..."
        read -r
        
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Set BREW_CMD after installation
        if [[ -x "/opt/homebrew/bin/brew" ]]; then
            BREW_CMD="/opt/homebrew/bin/brew"
        elif [[ -x "/usr/local/bin/brew" ]]; then
            BREW_CMD="/usr/local/bin/brew"
        fi
    else
        echo "Homebrew found at: $BREW_CMD"
    fi
    
    # Install required packages
    echo "Installing required packages with Homebrew..."
    $BREW_CMD install zsh coreutils unzip openssl@3
    
    # macOS doesn't use xdg-utils, so we skip that part
    echo "macOS package installation completed"
}

# Install packages based on OS
install_packages() {
    if [[ "$OS" == "linux" ]]; then
        install_linux_packages
    elif [[ "$OS" == "macos" ]]; then
        install_macos_packages
    fi
}

# Show daemon start instructions
show_daemon_instructions() {
    echo "=== Daemon Start Instructions ==="
    if [[ "$OS" == "linux" ]]; then
        echo "To start BrowserPipe service on Linux, run:"
        echo "systemctl --user enable BrowserPipe"
        echo "systemctl --user start BrowserPipe"
    elif [[ "$OS" == "macos" ]]; then
        echo "To start BrowserPipe service on macOS, run:"
        echo "launchctl load ~/Library/LaunchAgents/com.user.browserpipe.plist"
    fi
    echo "================================"
}

# Main execution
main() {
    echo "Starting dotfiles installation for $OSTYPE..."
    
    detect_os
    setup_directories
    setup_symlinks
    setup_starship
    install_tools
    setup_wsl "$@"
    install_packages
    show_daemon_instructions
    
    echo "Installation completed successfully!"
}

# Execute main function with all arguments
main "$@"
