#!/bin/sh

getAbsolutePath()
{
    if [ -d "$1" ]
    then
        (cd "$1" && $(pwd) || exit)
    else
        (cd $(dirname "$1") && echo $(pwd)/$(basename "$1") || exit)
    fi
}

SELF=$(getAbsolutePath "$0")
SELF_DIR=$(dirname "$SELF")
PARENT_DIR=$(dirname "$SELF_DIR")
JAR_DIR="$PARENT_DIR"/lib
JAR="$JAR_DIR"/sleep.jar
SCRIPTS_DIR="$PARENT_DIR"/scripts
SCRIPT="$SCRIPTS_DIR"/$(basename --suffix=.sh "$0").sl

java -jar "$JAR" "$SCRIPT" "$@"
