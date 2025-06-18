# Windsurf Configuration

Windsurf does not natively support XDG Base Directory specification. This directory provides scripts to manage Windsurf configuration in an XDG-compliant way for cross-environment persistence.

## Configuration Locations

- **Native Windsurf settings**: `~/Library/Application Support/Windsurf/User/`
- **Native MCP config**: `~/.codeium/windsurf/mcp_config.json`
- **XDG-managed location**: `$XDG_CONFIG_HOME/windsurf/` (this directory)

## Usage

### Backup Current Configuration
```bash
bash $XDG_CONFIG_HOME/windsurf/backup.sh
```

### Restore Configuration (New Environment)
```bash
bash $XDG_CONFIG_HOME/windsurf/install.sh
```

## What Gets Managed

- User settings (`settings.json`)
- Key bindings (`keybindings.json`)
- MCP configuration (`mcp_config.json`)
- Extensions list (`extensions.txt`)

## Workflow

1. **Setup**: Configure Windsurf on your primary machine
2. **Backup**: Run `backup.sh` to save settings to dotfiles
3. **Commit**: Add changes to git and push
4. **Restore**: On new environment, run `install.sh` after cloning dotfiles

This approach ensures your Windsurf settings, including MCP server configurations, persist across environments while respecting the XDG Base Directory structure of this dotfiles repository.