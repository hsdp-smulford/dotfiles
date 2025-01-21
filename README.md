# ✨ Dotfiles ✨

Welcome to my dotfiles! 🎉 These configs are designed to live happily in your `~/.config` directory, bringing joy to your development environment while playing nice with your system defaults! 🌈

## 🎁 What's Inside

- 🐚 Shell customizations that'll make you smile
- ✏️ Editor preferences for happy coding
- 🛠️ Development tools that spark joy
- 🖥️ Terminal settings for maximum comfort 
- 🌟 Git configurations for seamless version control
- 🔧 Installation scripts that respect your existing setup

## 🚀 Installation

1. Clone this treasure chest:
```bash
git clone https://github.com/hsdp-smulford/dotfiles.git
```

2. Create your config home (if it doesn't exist):
```bash
mkdir -p ~/.config
```

3. Let the magic happen:
```bash
# Create symlinks for what you need! ✨
ln -s $(pwd)/dotfiles/nvim ~/.config/nvim
ln -s $(pwd)/dotfiles/zsh ~/.config/zsh
```

## 📁 Structure

```
.
├── nvim/         # 🎨 Neovim configuration
├── zsh/          # 🐚 ZSH user configuration
├── git/          # 🌳 Git user configuration
├── ...
└── scripts/      # 🔧 Utility scripts
```

## 🛡️ Safety Features

- 🏠 All configs live peacefully in `~/.config`
- 🔗 Uses symlinks for easy updates
- 🔒 Keeps your system files safe
- 🎯 Easy to enable/disable specific configs
- 💾 Preserves your existing setup

## 🎮 Usage

1. 👀 Check out the configs you want
2. 🔗 Symlink your favorites
3. 🚀 Power up your shell:
```bash
# Add to your ~/.zshrc or ~/.bashrc
source ~/.config/zsh/custom.zsh
```

## 🎨 Customization

Feel free to remix these configs! The structure makes it easy to:
- ➕ Add new goodies
- 🔄 Modify existing setups
- ➖ Remove what you don't need
- 🎯 Keep your changes separate from system files

## 💾 Backup

Even though these configs are super careful, it's good to have backups:
```bash
cp -r ~/.config/nvim ~/.config/nvim.backup
cp -r ~/.config/zsh ~/.config/zsh.backup
```
