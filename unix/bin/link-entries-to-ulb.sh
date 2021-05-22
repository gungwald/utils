#!/bin/sh

TARGET_DIRECTORY=/usr/local/bin

linkEntries()
{
    if [ $# -lt 2 ]
    then
        echo 'linkEntries():' missing arguments 1>&2
    else
        for FILE in "$1"/*
        do
            if [ -f "$FILE" -a -x "$FILE" ]
            then
                echo Creating link in $2 to $FILE
                ln -s "$FILE" "$2"
            fi
        done
    fi
}

if [ $# -gt 0 ]
then
    for DIRECTORY in "$@"
    do
        linkEntries "$DIRECTORY" "$TARGET_DIRECTORY"
    done
else
    linkEntries `pwd` "$TAGET_DIRECTORY"
fi
