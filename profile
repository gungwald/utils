#!/bin/sh

if [ $# -eq 0 ]; then
  echo $0: Missing directory parameter
  exit 1
fi

topDir="$1"

isNotInPath() {
    echo $PATH | grep -qv "$1"
}

for subDir in "$topDir"/*; do
  if [ -d "$subDir" ]; then
    if [ -f "$subDir"/profile ]; then
      . "$subDir"/profile
      if isSupported; then
	binDir="$subDir"/bin
        # Avoid duplicate entries in the PATH.
        if isNotInPath "$binDir"; then
          PATH=$PATH:$binDir
        fi
      fi
    fi
  fi
done

export PATH
