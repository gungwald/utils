#!/bin/sh

BIN_DIR=`dirname "$0"`
if [ "$BIN_DIR" = "." ]
then
    BIN_DIR=`pwd`
fi

CLS_DIR=`dirname "$BIN_DIR"`/classes
MAIN_CLS=JavaCryptographicExtensionStrength

java -classpath "$CLS_DIR" $MAIN_CLS "$@"
