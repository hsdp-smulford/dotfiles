#!/bin/bash
#
# Script: claude.sh
# Description: Efficient wrapper for Claude AI that loads preferences from CLAUDE.md
# Location: $XDG_CONFIG_HOME/claude/claude.sh
# Usage: claude [--full] [other claude args]

# Use XDG environment variables with fallbacks
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
CLAUDE_CONFIG_HOME="${CLAUDE_CONFIG_HOME:-$XDG_CONFIG_HOME/claude}"

# Configuration paths
CONFIG_PATH="$CLAUDE_CONFIG_HOME/CLAUDE.md"
CACHE_DIR="$XDG_CACHE_HOME/claude"
CACHE_FILE="$CACHE_DIR/session_id"
SESSION_EXPIRY_DAYS=7  # How many days a session ID should be considered valid

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Function to extract a short version of preferences
create_short_preferences() {
  # Parameter not used but kept for future extensibility
  # shellcheck disable=SC2034
  local full_prefs="$1"

  # Extract just key sections for a condensed version
  echo "# DevOps Preferences Summary (condensed from CLAUDE.md)"
  echo ""
  echo "- Senior DevOps engineer focused on AWS, Kubernetes, Terraform, and GitOps"
  echo "- Prefer security-first, minimal solutions that follow existing patterns"
  echo "- Code should be self-documenting without comments, using clear naming"
  echo "- Focus on: containerization, IaC, cloud architecture, CI/CD automation"
  echo "- Value simplicity, reuse, and pattern consistency in all solutions"
  echo ""
  echo "Note: Use '/load_full_prefs' command to load complete CLAUDE.md if needed."
}

# Function to get CLAUDE.md content
get_claude_preferences() {
  if [ -f "$CONFIG_PATH" ]; then
    cat "$CONFIG_PATH"
  else
    echo "⚠️ CLAUDE.md not found at $CONFIG_PATH"
    exit 1
  fi
}

# Check if we have a cached session ID that's still valid
have_valid_session() {
  if [ ! -f "$CACHE_FILE" ]; then
    return 1
  fi

  # Check if the cache file is less than SESSION_EXPIRY_DAYS old
  local file_age
  file_age=$(find "$CACHE_FILE" -mtime -"$SESSION_EXPIRY_DAYS" 2>/dev/null | wc -l)
  if [ "$file_age" -eq 0 ]; then
    return 1
  fi

  # For now, just assume it's valid if not too old
  return 0
}

# Default to short preferences mode
USE_FULL_PREFS=0
CLAUDE_ARGS=()

# Parse arguments for special flags
for arg in "$@"; do
  if [ "$arg" = "--full" ]; then
    USE_FULL_PREFS=1
  else
    # Only add args that aren't our custom flags
    CLAUDE_ARGS+=("$arg")
  fi
done

# Get the preferences
FULL_PREFERENCES=$(get_claude_preferences)
SHORT_PREFERENCES=$(create_short_preferences "$FULL_PREFERENCES")

# Decide what to use based on mode and session state
if [ "$USE_FULL_PREFS" -eq 1 ]; then
  # User explicitly requested full preferences
  PROMPT_PREFIX="I'd like you to follow these complete guidelines for our interaction. This is my CLAUDE.md file that contains my preferences for how we work together:"
  PREFERENCES="$FULL_PREFERENCES"
  echo "🤖 Starting Claude with FULL preferences"
elif have_valid_session; then
  # We have a valid session - use minimal reminder
  PROMPT_PREFIX="Reminder to follow my DevOps preferences as previously discussed:"
  PREFERENCES="$SHORT_PREFERENCES"
  echo "🤖 Starting Claude with cached session and SHORT preferences"
else
  # New session - use short preferences
  PROMPT_PREFIX="I'd like you to follow these guidelines for our interaction. This is a summary of my preferences from CLAUDE.md:"
  PREFERENCES="$SHORT_PREFERENCES"
  echo "🤖 Starting Claude with SHORT preferences"
fi

# Prepare the complete prompt
PROMPT="${PROMPT_PREFIX}\n\n${PREFERENCES}\n\nPlease acknowledge briefly and then I'll continue with my actual question. NOTE: If I say '/load_full_prefs' during our conversation, please load my complete CLAUDE.md file, which I'll share at that point."

# Create a temporary file for viewing the prompt
TEMP_FILE=$(mktemp)
echo -e "$PROMPT" > "$TEMP_FILE"

# Check if claude is installed
if ! command -v claude &> /dev/null; then
  echo "⚠️ claude command not found"
  rm "$TEMP_FILE"
  exit 1
fi

# Since we can't pipe to claude directly, show instructions to copy/paste
echo ""
echo "📋 Copy the following text and paste it as your first message to Claude:"
echo "-------------------------------------------------------------------"
echo -e "$PROMPT" | head -n 10
echo "... (truncated) ..."
echo "-------------------------------------------------------------------"
echo ""
echo "The full prompt has been saved to: $TEMP_FILE"
echo "You can view it with 'cat $TEMP_FILE'"
echo ""

# Start claude with only the valid arguments
claude "${CLAUDE_ARGS[@]}"

# Update cache file with timestamp
touch "$CACHE_FILE"
