#!/bin/bash
for pattern in "$@"
do
  # Spaces in PATH will break this. You could "tr" the colons to a new line
  # and then read the directories as input. But, I like it like this.
  find ${PATH//:/ } -name "*${pattern}*" -print
done
