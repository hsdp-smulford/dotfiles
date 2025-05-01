#!/bin/bash
# Location: $XDG_CONFIG_HOME/claude-code/scripts/get_github_token.sh

# Fetch GitHub token from 1Password
GITHUB_TOKEN=$(op item get "GitHub" --vault "Private" --fields label="personal-access-token")

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: Failed to retrieve GitHub token" >&2
    exit 1
else
    echo "$GITHUB_TOKEN"
fi
