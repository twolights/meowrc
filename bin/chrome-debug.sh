#!/bin/bash

# Launch Chrome with remote debugging enabled.
# Usage: chrome-debug.sh [-p PORT] [-d PROFILE_DIR] [-- chrome-args...]

set -e

PORT=9222
PROFILE_DIR="$HOME/test/chrome_debug_profile"
UNSAFE_EXT_DEBUG=0

usage() {
    cat <<EOF
Usage: $(basename "$0") [-p PORT] [-d PROFILE_DIR] [-u] [-- chrome-args...]

Options:
  -p PORT          Remote debugging port (default: 9222)
  -d PROFILE_DIR   User data directory (default: \$HOME/test/chrome_debug_profile)
  -u               Enable unsafe extension debugging
  -h               Show this help message

Any arguments after -- are passed through to Chrome.
EOF
}

while getopts "p:d:uh" opt; do
    case "$opt" in
        p) PORT="$OPTARG" ;;
        d) PROFILE_DIR="$OPTARG" ;;
        u) UNSAFE_EXT_DEBUG=1 ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

mkdir -p "$PROFILE_DIR"

case "$(uname -s)" in
    Darwin)
        CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        ;;
    Linux)
        CHROME=$(command -v google-chrome || command -v google-chrome-stable || command -v chromium || command -v chromium-browser)
        ;;
    *)
        echo "Error: unsupported OS $(uname -s)" >&2
        exit 1
        ;;
esac

if [ ! -x "$CHROME" ]; then
    echo "Error: Chrome executable not found" >&2
    exit 1
fi

echo "Starting Chrome with remote debugging on port $PORT"
echo "Profile directory: $PROFILE_DIR"

CHROME_ARGS=(
    --remote-debugging-port="$PORT"
    --user-data-dir="$PROFILE_DIR"
)

if [ "$UNSAFE_EXT_DEBUG" = 1 ]; then
    CHROME_ARGS+=(--enable-unsafe-extension-debugging)
fi

exec "$CHROME" "${CHROME_ARGS[@]}" "$@"
