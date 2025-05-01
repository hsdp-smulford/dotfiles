#!/bin/bash
# Location: $XDG_CONFIG_HOME/claude-code/scripts/get_1password_key.sh

# Check if logged in to 1Password
op account get --format=json > /dev/null 2>&1
OP_STATUS=$?

if [ $OP_STATUS -ne 0 ]; then
    echo "Logging in to 1Password..." >&2
    eval $(op signin)
fi

# Fetch API key from 1Password
# Replace 'Anthropic' with your vault name and 'Claude API Key' with your item name
ANTHROPIC_API_KEY=$(op item get "Anthropic Claude" --vault "Private" --fields label="claude-key-for-windsurf")

if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "Error: Failed to retrieve API key from 1Password" >&2
    exit 1
else
    echo "$ANTHROPIC_API_KEY"
fi
