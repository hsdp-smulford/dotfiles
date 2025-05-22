#!/bin/bash
# Location: $XDG_CONFIG_HOME/claude-code/scripts/get_1password_key.sh

# Check if API key is available in environment
if [ -n "$CLAUDE_API_KEY" ]; then
    echo "$CLAUDE_API_KEY"
    exit 0
fi

# Check if logged in to 1Password
op account get --format=json > /dev/null 2>&1
OP_STATUS=$?

if [ $OP_STATUS -ne 0 ]; then
    # Try silent login with 1Password CLI biometric auth first
    op signin --account my.1password.com > /dev/null 2>&1
    OP_STATUS=$?

    # If silent login fails, try interactive
    if [ $OP_STATUS -ne 0 ]; then
        eval "$(op signin)"
    fi
fi

# Fetch API key from 1Password
ANTHROPIC_API_KEY=$(op item get "Anthropic Claude" --vault "Private" --fields label="claude-key-for-windsurf")

if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "Error: Failed to retrieve API key from 1Password" >&2
    exit 1
else
    echo "$ANTHROPIC_API_KEY"
fi
