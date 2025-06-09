# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages system configuration files and development environment setup for macOS. The repository follows XDG Base Directory specification with configurations symlinked from `~/dev/dotfiles/config` to `~/.config`.

## Key Architecture

- **XDG Compliance**: All configurations follow XDG Base Directory specification
  - `~/.config` → symlinked from `~/dev/dotfiles/config`
  - `~/.local/share` → XDG_DATA_HOME (oh-my-zsh, plugins)
  - `~/.local/state` → XDG_STATE_HOME (shell history, logs)
  - `~/.local/cache` → XDG_CACHE_HOME (temporary files)

- **Package Management**: Homebrew with centralized Brewfile at `config/brew/Brewfile`
- **Shell Environment**: ZSH with Oh My Zsh, Powerlevel10k theme, and XDG-compliant paths
- **Development Tools**: Heavy focus on DevOps tooling (AWS, Kubernetes, Terraform, Docker)

## Common Commands

### Package Management
```bash
# Install all packages from Brewfile
brew bundle --file="$XDG_CONFIG_HOME/brew/Brewfile"

# Install packages using the convenience script
bash config/brew/install.sh
```

### Python Development
```bash
# Install development dependencies
poetry install

# Run security scanning
detect-secrets scan
```

### System Setup (New Machine)
```bash
# 1. Clone repository
git clone git@github.com:hsdp-smulford/dotfiles.git ~/dev/dotfiles

# 2. Create XDG directories
mkdir -p ~/.local/{share,state,cache}
mkdir -p ~/.local/share/zsh ~/.local/state/zsh ~/.local/state/homebrew/logs ~/.local/cache/homebrew

# 3. Install Oh My Zsh to XDG location
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mv ~/.oh-my-zsh ~/.local/share/oh-my-zsh

# 4. Create symlinks
rm -rf ~/.config && ln -s ~/dev/dotfiles/config ~/.config

# 5. Install system zshrc (optional)
sudo cp ~/.config/zsh/zshrc.system /etc/zshrc
```

## Configuration Structure

- `config/zsh/` - ZSH configuration with XDG paths
- `config/git/` - Git configuration and aliases
- `config/nvim/` - Neovim configuration
- `config/brew/Brewfile` - Homebrew package definitions
- `config/claude/` - Claude-specific configurations and contexts
- `config/*` - Individual application configurations

## Development Environment

This setup targets DevOps workflows with tools for:
- AWS (CLI, SAM, IAM tools, vault)
- Kubernetes (kubectl, k9s, helm, ArgoCD)
- Infrastructure as Code (Terraform, Terragrunt, tflint)
- Container workflows (Docker, Colima, k3d, kind)
- CI/CD (GitHub CLI, act for local GitHub Actions)
- Monitoring (Prometheus tooling, observability)

## Important Notes

- All configurations respect XDG Base Directory specification
- Homebrew uses XDG paths for cache and state
- ZSH history and plugins follow XDG conventions
- System-wide zsh configuration available at `config/zsh/zshrc.system`
- Security scanning configured via detect-secrets in pyproject.toml