#!/bin/bash
# Script to install pre-commit hooks in a new repository

set -e

echo "🔄 Installing pre-commit hooks..."

# Check if pre-commit is installed
if ! command -v pre-commit &> /dev/null; then
    echo "⚠️  pre-commit is not installed. Installing via Homebrew..."
    brew install pre-commit
fi

# Check if we have a pre-commit config file
if [ ! -f .pre-commit-config.yaml ]; then
    echo "📝 No .pre-commit-config.yaml found. Copying the global template..."
    cp ~/.config/git/pre-commit-config.yaml .pre-commit-config.yaml
    echo "👉 You may want to customize .pre-commit-config.yaml for this project."
fi

# Initialize secrets baseline if it doesn't exist
if [ ! -f .secrets.baseline ]; then
    echo "🔑 Creating secrets baseline file..."
    detect-secrets scan > .secrets.baseline
fi

# Install the hooks
echo "🔧 Installing pre-commit hooks in this repository..."
pre-commit install

echo "✅ Pre-commit hooks installed successfully!"
echo "   To run the hooks manually: pre-commit run --all-files"