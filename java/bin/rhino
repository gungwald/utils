#!/bin/sh

BIN_DIR=$(dirname "$0")
if [ "$BIN_DIR" = "." ]; then
    BIN_DIR=$(pwd)
fi

TOP_DIR=$(dirname "$BIN_DIR")
LIB_DIR="$TOP_DIR"/lib
SELF=$(basename "$0")

exec java -jar "$LIB_DIR"/"$SELF".jar "$@"
