#!/bin/sh

SCRIPT_EXTENSION=".pl"

# The parentheses around the body instead of curly braces runs the body
# in a sub-shell.
# $1 - The file name for which the absolute directory is to be determined.
# Output - The absolute directory path of $1
absdirname() (
  cd `dirname "$1"`
  pwd
)

BIN_DIR=`absdirname "$0"`
TOP_DIR=`dirname "$BIN_DIR"`
SCRIPT_DIR="$TOP_DIR"/scripts

for SCRIPT in `ls "$SCRIPT_DIR"/*"$SCRIPT_EXTENSION"`
do
  SCRIPT_LINK=`basename "$SCRIPT" "$SCRIPT_EXTENSION"`
  ln -s "$SCRIPT" "$BIN_DIR"/"$SCRIPT_LINK"
done
