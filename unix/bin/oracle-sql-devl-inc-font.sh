#!/bin/bash

FONT_SIZE=16
IDE_PROP_FILES=$(find ~/.sqldeveloper -name ide.properties -print)

for IDE_PROP_FILE in $IDE_PROP_FILES
do
	sed --in-place=.orig "s/Ide.FontSize=[[:digit:]]\+$/Ide.FontSize=$FONT_SIZE/" "$IDE_PROP_FILE"
done

