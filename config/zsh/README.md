# Zsh Configuration Documentation

This directory contains your Zsh shell configuration files.

## Directory Contents

```
~/.config/zsh/
├── .p10k.zsh          # Powerlevel10k theme configuration
├── .zcompdump-*       # Zsh completion cache
├── .zshrc             # Main Zsh configuration file
```

## .zshrc Breakdown

Your `.zshrc` is a comprehensive configuration for a modern DevOps workflow. Here's a breakdown of its key components:

### Base Configuration

- **XDG Base Directory**: Follows the XDG specification for config organization
- **History Configuration**: Extended history with 1,000,000 entries, duplicate prevention
- **Completion System**: Modern tab completion with colors and fuzzy matching
- **Directory Navigation**: Auto CD, directory stack, and pushd/popd enhancements

### Package Managers and Languages

- **Homebrew**: Primary package manager with custom environment variables
- **Python**: PyEnv for Python version management
- **Go**: Go language configuration
- **Node.js**: NVM for Node.js version management

### Shell Enhancements

- **Powerlevel10k**: Modern, fast Zsh theme with instant prompt
- **FZF**: Fuzzy finder for files, history, and more
- **Modern CLI Tools**: Replacements for standard Unix tools (bat, eza, etc.)
- **Direnv**: Directory-specific environment variables
- **Atuin**: Enhanced shell history with SQLite backend
- **Zoxide**: Smarter directory jumping (cd replacement)
- **TheFuck**: Auto-corrects mistyped commands

### DevOps Tools Configuration

- **Kubernetes**: Extensive aliases and functions for kubectl
- **Docker**: Aliases for container management
- **AWS**: Profile management and helper functions
- **Terraform**: Aliases and environment setup
- **Git**: Comprehensive Git aliases and workflows

### Custom Functions

- **awsp**: Enhanced AWS profile selection with preview
- **kctxf**: Kubernetes context switching with preview
- **hcd**: Quick access to HAP directories
- **aws-ssh**: SSH to AWS instances via SSM
- **brew-housekeeping**: Homebrew maintenance
- **extract**: Universal archive extraction

## Powerlevel10k (.p10k.zsh)

This file contains your Powerlevel10k theme configuration. Notable features:

- Instant prompt for faster shell startup
- Custom prompt segments for Git, AWS, Kubernetes
- Icons for various states and conditions

## How to Use

### Editing Configuration

```zsh
# Edit main config
vim ~/.config/zsh/.zshrc

# Edit theme config
vim ~/.config/zsh/.p10k.zsh
```

### Key Aliases and Functions

#### Kubernetes
- `k` - kubectl
- `kgp` - get pods
- `kgd` - get deployments
- `kctxf` - fuzzy switch context

#### Docker
- `d` - docker
- `dc` - docker compose
- `dcu` - docker compose up
- `dcd` - docker compose down

#### AWS
- `awsp` - fuzzy select AWS profile
- `aws-ssh` - fuzzy select and connect to EC2 instance

#### Git
- `g` - git
- `gaa` - git add all
- `gst` - git status
- `gp` - git push

#### Terraform
- `tf` - terraform
- `tfi` - terraform init
- `tfp` - terraform plan
- `tfa` - terraform apply

#### Fun Commands
- `header` - Show random ASCII art header
- `rainbow` - Colorize text with lolcat
- `matrix` - Matrix animation
- `pipes` - Animated pipes

### Updating Configuration

1. **Add new aliases/functions**: Edit ~/.config/zsh/.zshrc
2. **Add new plugins**: Add to plugins=() array in .zshrc and install if custom
3. **Update theme**: Run `p10k configure`

## Customizing Powerlevel10k

To customize your prompt:

```zsh
p10k configure
```

Or manually edit `~/.config/zsh/.p10k.zsh`

## Plugins Management

Your configuration uses Oh My Zsh plugins. To update:

```zsh
# Update Oh My Zsh
omz update

# Update custom plugins
cd ~/.local/share/oh-my-zsh/custom/plugins/fast-syntax-highlighting && git pull
cd ~/.local/share/oh-my-zsh/custom/plugins/forgit && git pull
cd ~/.local/share/oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
```

## Troubleshooting

1. **Slow Startup**: Check for startup issues with `zsh -xvs 2>&1 | grep -v "^+"`
2. **Plugin Errors**: Ensure plugins are correctly installed
3. **Syntax Errors**: Run `zsh -n ~/.config/zsh/.zshrc` to check for syntax errors
4. **Command Not Found**: Ensure tools are installed with `brew install [tool]`
5. **P10k Instant Prompt Issues**: Ensure no console output during startup

## Homebrew Packages

Your configuration uses numerous Homebrew packages. To maintain:

```zsh
# Run your custom maintenance function
brew-housekeeping
```

Key packages include:
- Modern replacements (bat, eza, dust, fd, procs, btop)
- DevOps tools (kubectl, k9s, docker, terraform, aws-cli)
- Productivity tools (fzf, ripgrep, neovim)
- Fun tools (lolcat, figlet, cmatrix, neofetch)
