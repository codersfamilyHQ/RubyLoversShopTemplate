#!/bin/sh
set -e

# This lets us use LOCAL_GEMS env var in development - because after setting it,
# we need to run "bundle install" inside the container.
bundle check || bundle install --jobs 5 && bundle binstubs --all --path "$BUNDLE_BIN"

exec "$@"
