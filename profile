#!/bin/sh

echo "$@"
set

absolutePath() {
  if [ -d "$1" ]
  then
    ( cd "$1" || exit ; pwd )
  elif [ -f "$1" ]
  then
    ( cd "$(dirname "$1")" || exit ; echo "$(pwd)/$(basename "$1")" )
  fi
}


TOP_DIR=$(absolutePath "$0")
echo $TOP_DIR

#unset pathAddition
#for BIN_DIR in "$TOP_DIR"/*/bin; do
  #if [ -d "$BIN_DIR" ]; then
    #if [ -z "$pathAddition" ]; then
      #pathAddition=$BIN_DIR
    #else
      #pathAddition=$pathAddition:$BIN_DIR
    #fi
  #fi
#done

#if [ -n "$pathAddition" ]; then
  #PATH=$PATH:$pathAddition
  #export PATH
#fi
