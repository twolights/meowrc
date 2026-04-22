#!/usr/bin/env bash
# slack-notify-if-away.sh
#
# Thin wrapper for Claude Code's Notification hook that fires a Slack
# message via an existing `slack-notify-channel.sh` — but only when the
# user is "away" from the local Mac. Pairs naturally with tms's own
# macOS banner hook: when you're at the keyboard, tms catches your
# attention locally and Slack stays quiet; when you've stepped away or
# you're on a remote SSH session, Slack fires so you still get pinged.
#
# Reads on stdin: the Claude Code Notification payload (same JSON that
# tms notify-hook consumes). Extracts `.message` (verbatim) and `.cwd`
# (for the project label) so the Slack body matches what tms would
# show on the local banner.
#
# Away heuristic:
#   - In an SSH session (SSH_CONNECTION / SSH_TTY / SSH_CLIENT set)
#       → fire immediately.
#   - On a non-Darwin host (Linux, BSD, etc.)
#       → fire immediately (no HID-idle detection wired up here).
#   - On macOS with unreadable ioreg
#       → fail open, fire.
#   - On macOS with idle >= threshold
#       → fire.
#   - Otherwise (active at the local Mac)
#       → suppress.
#
# Intended to be registered in ~/.claude/settings.json as a Notification
# hook command, e.g.:
#
#   {
#     "matcher": "",
#     "hooks": [
#       {
#         "type": "command",
#         "command": "~/bin/claude-code-slack-notify-if-away.sh"
#       }
#     ]
#   }
#
# Tunable via env:
#   TMS_NOTIFY_IDLE_THRESHOLD_SEC  (default 300, i.e. 5 min)
#   SLACK_CHANNEL                  (default ai-coders)
#   SLACK_SENDER                   (default $HOME/bin/slack-notify-channel.sh)

set -euo pipefail

IDLE_THRESHOLD_SEC="${TMS_NOTIFY_IDLE_THRESHOLD_SEC:-300}"
SLACK_CHANNEL="${SLACK_CHANNEL:-ai-coders}"
SLACK_SENDER="${SLACK_SENDER:-$HOME/bin/slack-notify-channel.sh}"

# --- away/idle gate ----------------------------------------------------

should_fire=false
if [[ -n "${SSH_CONNECTION:-}${SSH_TTY:-}${SSH_CLIENT:-}" ]]; then
    should_fire=true
elif [[ "$(uname -s)" != "Darwin" ]]; then
    should_fire=true
else
    # macOS: read HIDIdleTime (nanoseconds since last HID event).
    # Read to EOF (no awk `exit`) — an early-exit closes the pipe while
    # ioreg is still writing, and under `set -o pipefail` the resulting
    # SIGPIPE propagates and exits the script with 141.
    ns=$(ioreg -c IOHIDSystem 2>/dev/null | awk '/HIDIdleTime/ {val=$NF} END{print val}')
    if [[ -z "$ns" ]]; then
        should_fire=true   # unreadable → fail open
    else
        idle_sec=$((ns / 1000000000))
        (( idle_sec >= IDLE_THRESHOLD_SEC )) && should_fire=true
    fi
fi

if ! $should_fire; then
    # Drain stdin so Claude Code's write-end closes cleanly, then exit 0.
    cat >/dev/null 2>&1 || true
    exit 0
fi

# --- extract message body + project from the hook payload -------------

payload=$(cat)

# Prefer jq (installed as a tms prereq); fall back to a narrow sed
# extractor for flat JSON string fields (same fallback tms uses).
_extract() {
    local field="$1"
    if command -v jq >/dev/null 2>&1; then
        printf '%s' "$payload" | jq -r --arg f "$field" '.[$f] // empty' 2>/dev/null
    else
        printf '%s' "$payload" \
            | sed -n "s/.*\"${field}\"[[:space:]]*:[[:space:]]*\"\\([^\"]*\\)\".*/\\1/p" \
            | head -1
    fi
}

message=$(_extract "message")
cwd=$(_extract "cwd")

project="unknown"
[[ -n "$cwd" ]] && project=$(basename "$cwd")

# Short hostname (no domain). Helps disambiguate notifications from
# multiple hosts (e.g., when the same Slack channel receives events
# from both the local Mac and an SSH'd Linux dev box).
host=$(hostname -s 2>/dev/null || hostname 2>/dev/null || printf 'unknown')

# Match the tms banner shape: project name + verbatim Claude message,
# with @host for multi-host disambiguation.
body="💫 ${message:-Claude Code needs your attention} 🏗️ <${project}>@${host}"

exec "$SLACK_SENDER" "$SLACK_CHANNEL" "$body"
