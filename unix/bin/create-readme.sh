#!/bin/sh
# Desc:Creates a README.md file for github containing all content in this repo
# shellcheck disable=SC2006
scriptDir=`dirname "$0"` && [ "$scriptDir" = "." ] && scriptDir=`pwd`
middleDir=`dirname "$scriptDir"`
topDir=`dirname "$middleDir"`
readme="$topDir"/README.md
rm "$readme"
echo '| Program Name | Description |' >> "$readme"
echo '| ------------ | ----------- |' >> "$readme"
for f in "$topDir"/*/bin/*
do
  name=`basename "$f"`
  desc=`grep -i 'desc:' "$f" | head -1 | cut -d: -f2-`
  [ $? ] && printf "| %s | %s |\n" "$name" "$desc" >> "$readme"
done
