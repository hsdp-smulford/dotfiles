#!/bin/bash

# Windsurf Configuration Backup Script
# Backs up Windsurf settings to XDG-compliant dotfiles location

set -e

WINDSURF_CONFIG_DIR="$HOME/Library/Application Support/Windsurf"
CODEIUM_DIR="$HOME/.codeium/windsurf"
DOTFILES_WINDSURF_DIR="$XDG_CONFIG_HOME/windsurf"

echo "Backing up Windsurf configuration..."

# Create backup directory structure
mkdir -p "$DOTFILES_WINDSURF_DIR/User"
mkdir -p "$DOTFILES_WINDSURF_DIR/codeium"

# Backup main Windsurf settings
if [[ -f "$WINDSURF_CONFIG_DIR/User/settings.json" ]]; then
    cp "$WINDSURF_CONFIG_DIR/User/settings.json" "$DOTFILES_WINDSURF_DIR/User/"
    echo "✓ Backed up User/settings.json"
fi

if [[ -f "$WINDSURF_CONFIG_DIR/User/keybindings.json" ]]; then
    cp "$WINDSURF_CONFIG_DIR/User/keybindings.json" "$DOTFILES_WINDSURF_DIR/User/"
    echo "✓ Backed up User/keybindings.json"
fi

# Backup MCP configuration
if [[ -f "$CODEIUM_DIR/mcp_config.json" ]]; then
    cp "$CODEIUM_DIR/mcp_config.json" "$DOTFILES_WINDSURF_DIR/codeium/"
    echo "✓ Backed up mcp_config.json"
fi

# Backup extensions list
if [[ -d "$WINDSURF_CONFIG_DIR/extensions" ]]; then
    code --list-extensions > "$DOTFILES_WINDSURF_DIR/extensions.txt" 2>/dev/null || windsurf --list-extensions > "$DOTFILES_WINDSURF_DIR/extensions.txt" 2>/dev/null || echo "Could not backup extensions list"
fi

echo "Windsurf configuration backed up to $DOTFILES_WINDSURF_DIR"