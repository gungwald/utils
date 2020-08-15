#!/bin/sh

# The $(...) syntax is not supported on some older systems so I'm sticking
# with the crappy old back-ticks instead. The next line turns off warnings
# about this in Intellij
# shellcheck disable=SC2006
true

MAIN_CLASS=MavenJarProjectCreator

getAbsolutePath() {
    cd "`dirname "$1"`" || exit
    echo "`pwd`/`basename "$1"`"
}

PROGRAM_NAME="`getAbsolutePath "$0"`"
PROGRAM_DIR="`dirname "$PROGRAM_NAME"`"
CLASSES_DIR="`dirname "$PROGRAM_DIR"`"/classes
exec java -classpath "$CLASSES_DIR" "$MAIN_CLASS" "$@"
