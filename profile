#!/bin/sh

TOP_DIR=(cd `dirname "$0"` ; pwd)
MY_NAME=`basename "$0" .sh`

unset PATH_ADDITION
for BIN_DIR in "$TOP_DIR"/*/bin
do
    if [ -d "$BIN_DIR" ]
    then
        if [ -z "$PATH_ADDITION" ]
        then
            PATH_ADDITION=$BIN_DIR
        else
            PATH_ADDITION=$PATH_ADDITION:$BIN_DIR
        fi
    fi
done

if [ -n "$PATH_ADDITION" ]
then
    PATH=$PATH:$PATH_ADDITION
    export PATH
fi

