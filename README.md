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

2. Set up symlinks:
```bash
# Link config directory
rm -rf ~/.config
ln -s ~/dev/dotfiles/config ~/.config
```

3. Install system-wide zsh configuration (if needed):
```bash
# Backup existing zshrc
sudo cp /etc/zshrc /etc/zshrc.backup

# Install new system zshrc
sudo cp ~/.config/zsh/zshrc.system /etc/zshrc
```

## Components

### ZSH Configuration
- `config/zsh/.zshrc` - Personal ZSH configuration
- `config/zsh/.p10k.zsh` - Powerlevel10k theme configuration
- `config/zsh/zshrc.system` → `/etc/zshrc` - System-wide ZSH configuration

### Application Configs
- `config/atuin/` - Shell history search
- `config/brew/` - Homebrew packages and installation
- `config/git/` - Git configuration and aliases
- `config/nvim/` - Neovim configuration
- And more in the `config/` directory

## New Machine Setup

1. Clone this repository to `~/dev/dotfiles`
2. Run the installation steps above
3. Install necessary packages and applications

## Contributing

Get off my lawn. 🌳🔪

## License

See [LICENSE](LICENSE) file.