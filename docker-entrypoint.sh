#!/bin/bash

set -e

if [[ -f Gemfile ]]; then
  bundle check || bundle install --binstubs="$BUNDLE_BIN"
fi

if [ $# -eq 0 ]; then
	exec /bin/bash
else
	echo "exec command => $@"
	exec "$@"
fi