#!/bin/sh

# Confluence exports files named with plus signs where spaces should be.
# This fixes those file names.

if [ $# = 0 ]
then
    echo No file names were provided on the command line. Nothing to do.
    exit 0
fi

if [ "$1" = '-t' ]
then
    shift
    TEST_ONLY=true
fi

RENAMED_AT_LEAST_ONE_FILE=false

for FILE_NAME in "$@"
do
    # Replace all pluses with spaces in the file name.
    FILE_NAME_WITHOUT_PLUSES=${FILE_NAME//+/ }
    if [ "$FILE_NAME_WITHOUT_PLUSES" != "$FILE_NAME" ]
    then
        RENAMED_AT_LEAST_ONE_FILE=true
        if [ "$TEST_ONLY" = 'true' ]
        then
            echo Would rename "$FILE_NAME" to "$FILE_NAME_WITHOUT_PLUSES"
        else
            echo Renaming "$FILE_NAME" to "$FILE_NAME_WITHOUT_PLUSES"
            mv "$FILE_NAME" "$FILE_NAME_WITHOUT_PLUSES"
        fi
    elif [ "$TEST_ONLY" = 'true' ]
    then
        echo No pluses found in $FILE_NAME.
    fi
done

if [ "$RENAMED_AT_LEAST_ONE_FILE" = 'false' ]
then
    echo No files needed renaming.
fi

