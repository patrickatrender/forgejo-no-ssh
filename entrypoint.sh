#!/bin/sh
set -e

# Start Docker daemon in background
dockerd --host=unix:///var/run/docker.sock &
DOCKER_PID=$!

# Wait for Docker to be ready
sleep 3

# Set Docker socket environment
export DOCKER_HOST=unix:///var/run/docker.sock

# Your runner config...
FORGEJO_URL="${FORGEJO_URL:-http://localhost:3000}"
FORGEJO_UUID="${FORGEJO_UUID:-}"
FORGEJO_TOKEN="${FORGEJO_TOKEN:-}"
FORGEJO_LABELS="${FORGEJO_LABELS:-docker:docker://node:lts}"

if [ -z "$FORGEJO_UUID" ] || [ -z "$FORGEJO_TOKEN" ]; then
    echo "Error: FORGEJO_UUID and FORGEJO_TOKEN required"
    exit 1
fi

echo -n "$FORGEJO_TOKEN" > /tmp/runner-token

exec forgejo-runner daemon \
    --url "$FORGEJO_URL" \
    --uuid "$FORGEJO_UUID" \
    --token-url file:///tmp/runner-token \
    --label "$FORGEJO_LABELS"