# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains personal dotfiles and system configuration files organized according to the XDG Base Directory specification. The main configuration files are stored in the `config` directory, which is symlinked to `~/.config` on the user's system.

## Common Commands

### Dotfiles Management

```bash
# Update Homebrew packages and save to Brewfile
~/.config/brew/backup.sh

# Install packages from Brewfile
~/.config/brew/install.sh

# Complete Homebrew maintenance (update, check/install from Brewfile, upgrade, cleanup)
brew-housekeeping
```

### Git Workflow

```bash
# Git is configured with separate personal and work profiles
# Personal profile is loaded by default
# Work profile is loaded for repositories in ~/work/

# Common git aliases are defined in ~/.config/git/aliases
# See these aliases with:
git config --get-regexp alias
```

## Configuration Architecture

### XDG Base Directory Structure

- `~/.config` → Configuration files (this repository)
- `~/.local/share` → Data files (oh-my-zsh, plugins, etc.)
- `~/.local/state` → State files (shell history, logs)
- `~/.local/cache` → Cache files (Homebrew, etc.)

### Development Environment Features

- **Tmux**: Terminal multiplexer configuration with sensible defaults
- **Direnv**: Project-specific environment management with support for various tech stacks
- **Git Hooks**: Pre-commit framework for code quality

### Key Configuration Areas

1. **Zsh**: Extensive shell configuration with plugins, themes, and custom functions
   - Uses Oh My Zsh with Powerlevel10k theme
   - Contains aliases and functions for DevOps workflows

2. **Git**: Configured with separate personal and work profiles
   - Includes custom aliases and commit template
   - Automatically detects work vs. personal repositories

3. **Homebrew**: Package management
   - Brewfile tracks installed packages
   - Installation and backup scripts available
   - brew-housekeeping function for comprehensive maintenance

4. **Claude Code**: Configuration for Claude Code CLI
   - Custom model configuration
   - API key management via 1Password
   - DevOps-focused rule sets

5. **K9s**: Kubernetes CLI dashboard configuration
   - Custom UI settings and resource monitoring thresholds

6. **Neovim**: Text editor configuration
   - Based on NvChad starter configuration

## Working with This Repository

### Adding New Configuration

1. Add configuration files to the appropriate directory in `~/dev/dotfiles/config/`
2. These will be available at `~/.config/` via the symlink

### Managing Dependencies

1. Install new packages with `brew install <package>`
2. Back up package list with `~/.config/brew/backup.sh` or `brew-housekeeping`
3. On a new system, restore packages with `~/.config/brew/install.sh`
4. For maintenance, use `brew-housekeeping` to check and install from Brewfile, update, and clean up

### Integrations and Security

- Credentials are managed via 1Password CLI integration
- API keys and tokens are retrieved from 1Password at runtime
- Git commit signing is supported but not required by default

### Claude Code Integration

- Custom rules for IaC validation, container security, and language best practices
- Configuration optimized for Python, Go, Terraform, and Kubernetes workflows
- Aliases defined for common Claude Code commands