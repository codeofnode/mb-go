#!/bin/bash
set -e

if [ "$1" = 'make' ]; then
	exec "$@"
fi

exec "$@"
