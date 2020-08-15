#!/bin/sh

BIN_DIR=$(dirname "$0")
if [ "$BIN_DIR" = "." ]
then
	BIN_DIR=$(pwd)
fi

TOP_DIR=$(dirname "$BIN_DIR")
LIB_DIR="$TOP_DIR"/lib
SCRIPTS_DIR="$TOP_DIR"/scripts
MY_NAME=$(basename "$0")

perl "$SCRIPTS_DIR"/"$MY_NAME".pl "$@" 

