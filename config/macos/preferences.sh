#!/bin/bash
# macOS preferences configuration file
# This file contains macOS defaults settings that should persist across reboots

# Disable dictation emoji
defaults write -g NSDisabledDictationEmoji -bool YES

# Set text insertion context prefix
defaults write -g NSTextInsertionContextPrefix -string '{ "type": "text", "content": "$0" }'

# Enable auto-copy to clipboard on text selection
defaults write -g NSServicesMinimumItemCount -int 2

# Terminal-specific clipboard settings
defaults write com.apple.Terminal CopySelection -bool true
defaults write com.apple.Terminal AutomaticQuoteSubstitution -bool false

# Set terminal selection behavior
defaults write -g ApplePressAndHoldEnabled -bool false

# Additional clipboard enhancement
defaults write -g NSAutomaticPasteboardModeEnabled -bool true

echo "macOS preferences applied successfully."
