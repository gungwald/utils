#!/bin/sh

if [ $# -eq 0 ]; then
  echo Missing directory parameter
  exit 1
fi

topDir="$1"

unset pathAddition
for subDir in "$topDir"/*; do
  if [ -d "$subDir" ]; then
    if [ -f "$subDir"/profile ]; then
      . "$subDir"/profile
      if isSupported; then
	binDir="$subDir"/bin
        if [ -z "$pathAddition" ]; then
          pathAddition=$binDir
        else
          pathAddition=$pathAddition:$binDir
        fi
      fi
    fi
  fi
done

if [ -n "$pathAddition" ]; then
  PATH=$PATH:$pathAddition
  export PATH
fi
