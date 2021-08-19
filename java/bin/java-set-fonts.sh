#!/bin/sh

FONT_NAME=monofur
FONT_TYPE=plain
FONT_SIZE=25
FONT_SPEC="$FONT_NAME-$FONT_TYPE-$FONT_SIZE"


# Swing fonts - Haven't gotten these to work
JDK_JAVA_OPTION="-Dswing.aatext=true -Dswing.plaf.metal.controlFont=$FONT_SPEC -Dswing.plaf.metal.userFont=$FONT_SPEC"

# Plastic fonts - Haven't gotten these to work
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -DWindows.controlFont=$FONT_SPEC -DWindows.menuFont=$FONT_SPEC -DPlastic.controlFont=$FONT_SPEC -DPlastic.menuFont=$FONT_NAME-bold-$FONT_SIZE"

# General scaling
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dsun.java2d.uiScale=2"
JDK_JAVA_OPTIONS="$JDK_JAVA_OPTIONS -Dsun.java2d.uiScale.enabled=true"

export JDK_JAVA_OPTIONS

