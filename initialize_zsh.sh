#!/bin/bash
# Pretzel's ZSH Configuration Script
# Checks prerequisites and configures alias loading

# --------------------------
# Environment Checks
# --------------------------

# Verify ZSH installation
if ! command -v zsh &> /dev/null; then
    echo "Error: zsh is not installed."
    echo "Please install zsh using your package manager:"
    echo "  Debian/Ubuntu: sudo apt install zsh"
    echo "  Fedora:        sudo dnf install zsh"
    echo "  macOS:         brew install zsh"
    exit 1
fi

# --------------------------
# File Validation
# --------------------------

ZSHRC_PATH="$HOME/.zshrc"

# Check for existing .zshrc
if [ ! -f "$ZSHRC_PATH" ]; then
    echo "Error: .zshrc not found in home directory - please launch and configure zsh."
    exit 2
fi

# --------------------------
# User Confirmation
# --------------------------

# Get user input with case normalization
read -rp "Add alias loader to .zshrc? [y/N] " response
normalized_response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

if [[ ! "$normalized_response" =~ ^(yes|y)$ ]]; then
    echo "No modifications made"
    exit 0
fi

# --------------------------
# Directory Management
# --------------------------

ALIAS_DIR="$HOME/.zsh_aliases"

# Create directory if missing
if [ ! -e "$ALIAS_DIR" ]; then
    echo "Creating alias directory: $ALIAS_DIR"
    mkdir -p "$ALIAS_DIR"
elif [ ! -d "$ALIAS_DIR" ]; then
    echo "Error: $ALIAS_DIR exists but is not a directory, you trying to break the script???"
    exit 3
fi

# --------------------------
# Configuration Update
# --------------------------

echo "Updating .zshrc configuration"

# Append alias loader with header
cat << EOF >> "$ZSHRC_PATH"

# --------------------------
# Auto-loaded Aliases
# --------------------------
# Load all .zsh files from alias directory
for file in "\$HOME/.zsh_aliases/"*.zsh; do
    [ -f "\$file" ] && source "\$file"
done
EOF

echo "Configuration complete. Restart to apply changes."
exit 0
