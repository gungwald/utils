#!/bin/sh

# Print only the lines that have at least one character on them.
sed -n /./p "$@"
