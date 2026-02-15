#!/bin/bash

# Claude Code Plugin Installer
# This script installs all plugins by directly updating settings.json
# (The `claude plugins install` CLI command is broken/hangs in some versions)

set -e

SETTINGS_FILE="$HOME/.claude/settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
    echo "Creating Claude Code settings file..."
    mkdir -p "$(dirname "$SETTINGS_FILE")"
    echo '{}' > "$SETTINGS_FILE"
fi

echo "Installing Claude Code plugins..."

# Define plugins to install
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
    "claude-mem@thedotmack"
)

# Build jq filter to add all plugins
JQ_FILTER='.enabledPlugins //= {}'
for plugin in "${PLUGINS[@]}"; do
    JQ_FILTER="$JQ_FILTER | .enabledPlugins[\"$plugin\"] = true"
done

# Update settings.json
if command -v jq &>/dev/null; then
    jq "$JQ_FILTER" "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    echo "Claude Code plugins installed successfully!"
else
    echo "Error: jq is required but not installed."
    echo "Install with: brew install jq"
    exit 1
fi
