#!/bin/sh
# Desc:Searches PATH for a command name containing a given substring
# shellcheck disable=SC2006
binDir=`dirname "$0"` && [ "$binDir" = "." ] && binDir=`pwd`
topDir=`dirname "$binDir"`
classesDir="$topDir"/classes
java -classpath "$classesDir" SearchPath "$@"
