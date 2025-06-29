#!/bin/sh
# shellcheck disable=SC2006
binDir=`dirname "$0"` && [ "$binDir" = "." ] && binDir=`pwd`
topDir=`dirname "$binDir"`
classesDir="$topDir"/classes
java -classpath "$classesDir" SearchPath "$@"
