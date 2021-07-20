#!/bin/sh

if [ $# -eq 0 ]; then
  echo Usage: $0 absolute-directory-name
  exit 1
fi

topDir="$1"

dedup() {
  # Magic
  awk '!visited[$0]++'
}

dedupPath() {
  PATH=`echo $PATH | tr ':' '\n' | dedup | tr '\n' ':' | head --bytes=-1`
}

isNotInPath() {
    echo $PATH | grep -qv "$1"
}

if [ `uname -s` != "SunOS" ]
then
  dedupPath
fi

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
