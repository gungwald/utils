#!/bin/sh

SCRIPT_EXTENSION=".pl"

toLowerCase()
{
  echo "$1" | tr '[:upper:]' '[:lower:]'
}

# The value of `uname -s` is not consistent across the various methods
# of running sh/bash on Windows. But, the $OS variable always exists on
# Windows.
isWindows()
{
	if [ "$OS" = "Windows_NT" ]
	then
		true
	else
		false
	fi
}

# The parentheses around the body instead of curly braces runs the body
# in a sub-shell.
# $1 - The file name for which the absolute directory is to be determined.
# Output - The absolute directory path of $1
absdirname()
(
  cd `dirname "$1"`
  pwd
)

CURR_DIR=`absdirname "$0"`
PARENT_DIR=`dirname "$CURR_DIR"`
SCRIPT_DIR="$CURR_DIR"/scripts
BIN_DIR="$CURR_DIR"/bin

for SCRIPT in `ls "$SCRIPT_DIR"/*"$SCRIPT_EXTENSION"`
do
  SCRIPT_LINK="$BIN_DIR"/`basename "$SCRIPT" "$SCRIPT_EXTENSION"`
  rm -f "$SCRIPT_LINK"
  # "ln" doesn't work on mingw
  if isWindows
  then
  	  cmd //c mklink "$SCRIPT_LINK" "$SCRIPT"
  else
  	  ln -s "$SCRIPT" "$SCRIPT_LINK"
  fi
done
