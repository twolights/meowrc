#!/bin/bash

# Claude Code Plugin Installer
# This script installs all plugins defined in the meowrc configuration

set -e

if ! command -v claude &>/dev/null; then
    echo "Claude Code is not installed. Skipping plugin installation."
    exit 0
fi

echo "Installing Claude Code plugins..."

# Official plugins
claude plugins install pyright-lsp@claude-plugins-official 2>/dev/null || true
claude plugins install rust-analyzer-lsp@claude-plugins-official 2>/dev/null || true
claude plugins install swift-lsp@claude-plugins-official 2>/dev/null || true
claude plugins install php-lsp@claude-plugins-official 2>/dev/null || true
claude plugins install frontend-design@claude-plugins-official 2>/dev/null || true
claude plugins install context7@claude-plugins-official 2>/dev/null || true

# Third-party plugins
claude plugins install scientific-skills@claude-scientific-skills 2>/dev/null || true
claude plugins install claude-mem@thedotmack 2>/dev/null || true

echo "Claude Code plugins installed successfully!"
