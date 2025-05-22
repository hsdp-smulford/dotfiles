# Claude XDG Environment Setup Guide

This guide will help you set up Claude AI with XDG directory structure, properly integrating with your existing dotfiles configuration.

## Directory Structure

After installation, your structure will look like this:

```
~/.config/
└── claude/                 # Consolidated Claude directory
    ├── CLAUDE.md           # Main preferences file
    ├── claude.sh           # Wrapper script
    └── code/               # Migrated from claude-code directory
        └── [claude-code files]
~/.cache/
└── claude/                 # Created automatically by the script
    └── session_id          # Managed by the script
```

## Installation Steps

### 1. Create the claude.sh script

```bash
# Make sure the directory exists
mkdir -p ~/.config/claude

# Save the script
cp ~/Downloads/claude.sh ~/.config/claude/claude.sh
chmod +x ~/.config/claude/claude.sh
```

### 2. Save the CLAUDE.md file

```bash
# Save the integrated preferences file
cp ~/Downloads/Integrated\ CLAUDE.md ~/.config/claude/CLAUDE.md
```

### 3. Update your .zshrc

Add the following to your .zshrc (locations based on your current file):

**Environment Variables Section** (around line 67):
```bash
# Replace this line:
export CLAUDE_CODE_CONFIG_HOME="$XDG_CONFIG_HOME/claude-code"

# With these lines:
export CLAUDE_CONFIG_HOME="$XDG_CONFIG_HOME/claude"
export CLAUDE_CODE_CONFIG_HOME="$CLAUDE_CONFIG_HOME"
```

**Aliases Section** (around line 270):
```bash
# Claude AI
alias claude="$CLAUDE_CONFIG_HOME/claude.sh"
alias claude-full="$CLAUDE_CONFIG_HOME/claude.sh --full-prefs"
```

**Utility Functions Section** (around line 360):
```bash
function claude-setup() {
  echo "Setting up Claude configuration..."
  mkdir -p "$CLAUDE_CONFIG_HOME"
  mkdir -p "$XDG_CACHE_HOME/claude"

  # Migrate claude-code if needed
  if [[ -d "$XDG_CONFIG_HOME/claude-code" && ! -d "$CLAUDE_CONFIG_HOME/code" ]]; then
    echo "Migrating claude-code → claude/code..."
    mkdir -p "$CLAUDE_CONFIG_HOME/code"
    cp -R "$XDG_CONFIG_HOME/claude-code/"* "$CLAUDE_CONFIG_HOME/code/"
    echo "Migration complete. You can remove $XDG_CONFIG_HOME/claude-code after verifying."
  fi

  # Check if the claude.sh script exists
  if [[ ! -f "$CLAUDE_CONFIG_HOME/claude.sh" ]]; then
    echo "Creating claude.sh script..."
    # If you have it locally
    cp ~/Downloads/claude.sh "$CLAUDE_CONFIG_HOME/claude.sh"
    chmod +x "$CLAUDE_CONFIG_HOME/claude.sh"
  else
    echo "claude.sh script already exists."
  fi

  # Check if CLAUDE.md exists
  if [[ ! -f "$CLAUDE_CONFIG_HOME/CLAUDE.md" ]]; then
    echo "Creating CLAUDE.md preferences file..."
    # If you have it locally
    cp ~/Downloads/Integrated\ CLAUDE.md "$CLAUDE_CONFIG_HOME/CLAUDE.md"
  else
    echo "CLAUDE.md already exists."
  fi

  echo "Claude configuration setup complete!"
}
```

### 4. Apply changes

```bash
source ~/.zshrc
```

### 5. Run the setup function to migrate claude-code

```bash
claude-setup
```

## Using Claude with Preferences

### Regular Usage (Minimal Tokens)

```bash
claude
```

### Full Preferences Mode

```bash
claude-full
```

### Loading Full Preferences During a Conversation

Type this in an active Claude conversation:
```
/load_full_prefs
```

## Adding to Your Dotfiles Repository

1. Make sure the config directory exists in your dotfiles repo:
   ```bash
   mkdir -p ~/dev/dotfiles/config/claude
   ```

2. Copy the files:
   ```bash
   cp ~/.config/claude/CLAUDE.md ~/dev/dotfiles/config/claude/
   cp ~/.config/claude/claude.sh ~/dev/dotfiles/config/claude/
   ```

3. Commit to your repository:
   ```bash
   cd ~/dev/dotfiles
   git add config/claude/CLAUDE.md config/claude/claude.sh
   git commit -m "Add Claude AI preferences and wrapper script"
   git push
   ```

## Troubleshooting

- **Script not found**: Verify `$CLAUDE_CONFIG_HOME` is correctly set and the script exists
- **Preferences file not found**: Ensure CLAUDE.md is at `$CLAUDE_CONFIG_HOME/CLAUDE.md`
- **Permission denied**: Verify script permissions with `chmod +x $CLAUDE_CONFIG_HOME/claude.sh`
