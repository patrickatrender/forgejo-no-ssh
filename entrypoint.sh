#!/bin/sh
set -e

FORGEJO_URL="${FORGEJO_URL:-http://localhost:3000}"
FORGEJO_UUID="${FORGEJO_UUID:-}"
FORGEJO_TOKEN="${FORGEJO_TOKEN:-}"

if [ -z "$FORGEJO_UUID" ] || [ -z "$FORGEJO_TOKEN" ]; then
    echo "Error: FORGEJO_UUID and FORGEJO_TOKEN required"
    exit 1
fi

echo -n "$FORGEJO_TOKEN" > /tmp/runner-token

# Shell executor with no Docker
exec forgejo-runner daemon \
    --url "$FORGEJO_URL" \
    --uuid "$FORGEJO_UUID" \
    --token-url file:///tmp/runner-token \
    --label shell \
    --label ubuntu-latest