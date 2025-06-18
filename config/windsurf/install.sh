#!/bin/bash

# Windsurf Configuration Install Script
# Restores Windsurf settings from XDG-compliant dotfiles location

set -e

WINDSURF_CONFIG_DIR="$HOME/Library/Application Support/Windsurf"
CODEIUM_DIR="$HOME/.codeium/windsurf"
DOTFILES_WINDSURF_DIR="$XDG_CONFIG_HOME/windsurf"

echo "Installing Windsurf configuration from dotfiles..."

# Create necessary directories
mkdir -p "$WINDSURF_CONFIG_DIR/User"
mkdir -p "$CODEIUM_DIR"

# Restore main Windsurf settings
if [[ -f "$DOTFILES_WINDSURF_DIR/User/settings.json" ]]; then
    cp "$DOTFILES_WINDSURF_DIR/User/settings.json" "$WINDSURF_CONFIG_DIR/User/"
    echo "✓ Restored User/settings.json"
fi

if [[ -f "$DOTFILES_WINDSURF_DIR/User/keybindings.json" ]]; then
    cp "$DOTFILES_WINDSURF_DIR/User/keybindings.json" "$WINDSURF_CONFIG_DIR/User/"
    echo "✓ Restored User/keybindings.json"
fi

# Restore MCP configuration
if [[ -f "$DOTFILES_WINDSURF_DIR/codeium/mcp_config.json" ]]; then
    cp "$DOTFILES_WINDSURF_DIR/codeium/mcp_config.json" "$CODEIUM_DIR/"
    echo "✓ Restored mcp_config.json"
fi

# Install extensions
if [[ -f "$DOTFILES_WINDSURF_DIR/extensions.txt" ]]; then
    echo "Installing extensions..."
    while IFS= read -r extension; do
        code --install-extension "$extension" 2>/dev/null || windsurf --install-extension "$extension" 2>/dev/null || echo "Could not install extension: $extension"
    done < "$DOTFILES_WINDSURF_DIR/extensions.txt"
fi

echo "Windsurf configuration restored from $DOTFILES_WINDSURF_DIR"