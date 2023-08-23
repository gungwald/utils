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

CURR_DIR=`absdirname "$0"`
PARENT_DIR=`dirname "$CURR_DIR"`
SCRIPT_DIR="$CURR_DIR"/scripts
BIN_DIR="$CURR_DIR"/bin

for SCRIPT in `ls "$SCRIPT_DIR"/*"$SCRIPT_EXTENSION"`
do
  SCRIPT_LINK=`basename "$SCRIPT" "$SCRIPT_EXTENSION"`
  rm -f "$BIN_DIR"/"$SCRIPT_LINK"
  ln -s "$SCRIPT" "$BIN_DIR"/"$SCRIPT_LINK"
done
