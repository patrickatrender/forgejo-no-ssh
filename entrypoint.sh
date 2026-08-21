#!/bin/sh
set -e

# Replace env vars in config
sed -i "s|\${FORGEJO_URL}|${FORGEJO_URL}|g" /data/runner-config.yml
sed -i "s|\${FORGEJO_UUID}|${FORGEJO_UUID}|g" /data/runner-config.yml
sed -i "s|\${FORGEJO_TOKEN}|${FORGEJO_TOKEN}|g" /data/runner-config.yml

# Run with config file
exec forgejo-runner daemon --config /data/runner-config.yml