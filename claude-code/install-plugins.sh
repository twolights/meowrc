#!/bin/bash

# Claude Code Plugin Installer
# Uses `claude plugin` CLI commands to manage marketplace lists and plugins.

set -e

echo "Installing Claude Code plugins..."

# Third-party marketplace lists
MARKETPLACE_LISTS=(
    "cardmagic/ai-marketplace"
)

# Plugins to install
PLUGINS=(
    # Official plugins
    "pyright-lsp@claude-plugins-official"
    "rust-analyzer-lsp@claude-plugins-official"
    "swift-lsp@claude-plugins-official"
    "php-lsp@claude-plugins-official"
    "frontend-design@claude-plugins-official"
    "context7@claude-plugins-official"
    # Third-party plugins
    "scientific-skills@claude-scientific-skills"
    "reminders@cardmagic"
)

# Add marketplace lists
for list in "${MARKETPLACE_LISTS[@]}"; do
    echo "Adding marketplace list: $list"
    claude plugin marketplace add "$list"
done

# Install plugins
for plugin in "${PLUGINS[@]}"; do
    echo "Installing plugin: $plugin"
    claude plugin install "$plugin"
done

echo "Claude Code plugins installed successfully!"
