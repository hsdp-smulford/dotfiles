# Dotfiles

Personal configuration files and system setup.

## Structure

```
.
├── config/          # XDG_CONFIG_HOME files (~/.config)
│   ├── zsh/         # ZSH configuration
│   ├── git/         # Git configuration
│   └── ...          # Other app configs
├── etc.zshrc        # Reference copy of system /etc/zshrc
├── LICENSE
└── README.md        # YOU ARE HERE.
```

## Installation

1. Clone this repository:
```bash
git clone git@github.com:hsdp-smulford/dotfiles.git ~/dev/dotfiles
```

2. Set up XDG Base Directories:
```bash
# Create XDG Base Directory structure
mkdir -p ~/.local/{share,state,cache}
mkdir -p ~/.local/share/zsh
mkdir -p ~/.local/state/zsh
mkdir -p ~/.local/state/homebrew/logs
mkdir -p ~/.local/cache/homebrew
```

3. Install Oh My Zsh:
```bash
# Install Oh My Zsh to XDG_DATA_HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mv ~/.oh-my-zsh ~/.local/share/oh-my-zsh
```

4. Set up symlinks:
```bash
# Link config directory
rm -rf ~/.config
ln -s ~/dev/dotfiles/config ~/.config
```

5. Install system-wide zsh configuration (if needed):
```bash
# Backup existing zshrc
sudo cp /etc/zshrc /etc/zshrc.backup

# Install new system zshrc
sudo cp ~/.config/zsh/zshrc.system /etc/zshrc
```

6. Install required packages:
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages from Brewfile
brew bundle
```

## Components

### XDG Base Directory Structure
- `~/.config` → XDG_CONFIG_HOME (symlinked from this repo)
- `~/.local/share` → XDG_DATA_HOME (contains oh-my-zsh, plugins, etc.)
- `~/.local/state` → XDG_STATE_HOME (contains shell history, logs)
- `~/.local/cache` → XDG_CACHE_HOME (contains temporary files)

### ZSH Configuration
- `config/zsh/.zshrc` - Personal ZSH configuration
- `config/zsh/.p10k.zsh` - Powerlevel10k theme configuration
- `config/zsh/zshrc.system` → `/etc/zshrc` - System-wide ZSH configuration
- `~/.local/share/oh-my-zsh` - Oh My Zsh installation
- `~/.local/state/zsh/history` - ZSH history file

### Application Configs
- `config/atuin/` - Shell history search
- `config/brew/` - Homebrew packages and installation
- `config/git/` - Git configuration and aliases
- `config/nvim/` - Neovim configuration
- And more in the `config/` directory

### Homebrew XDG Paths
- `$XDG_CONFIG_HOME/brew/Brewfile` - Package definitions
- `$XDG_CACHE_HOME/homebrew` - Cache directory
- `$XDG_STATE_HOME/homebrew/logs` - Log files

## New Machine Setup

1. Clone this repository to `~/dev/dotfiles`
2. Run the installation steps above
3. Install necessary packages and applications
4. Verify ZSH plugin installation:
   ```bash
   # Check if zsh plugins are installed
   ls $(brew --prefix)/share/zsh-autosuggestions
   ls $(brew --prefix)/share/zsh-syntax-highlighting
   ```

## Troubleshooting

### Common Issues

1. **Powerlevel10k Warning**: If you see warnings about console output during zsh initialization, ensure `POWERLEVEL9K_INSTANT_PROMPT=quiet` is set at the very top of your .zshrc file.

2. **Missing Plugins**: If you see "plugin not found" warnings, verify that zsh plugins are installed via Homebrew and properly sourced in your .zshrc.

3. **History Not Working**: Ensure the XDG state directory exists and is writable:
   ```bash
   mkdir -p ~/.local/state/zsh
   ```

4. **Homebrew Bundle Not Finding Brewfile**: Verify the XDG environment variables are set:
   ```bash
   echo $HOMEBREW_BUNDLE_FILE
   ```

## Contributing

Get off my lawn. 🌳🔪

## License

See [LICENSE](LICENSE) file.