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
  # MacOS 12.3.1's head command can't handle negative values so it can't
  # be used to remove the trailing colon. The ${PATH%?} is POSIX and
  # works in every shell except old Bourne shells. It is also faster
  # than running an external process like 'head'.
  PATH=`echo $PATH | tr ':' '\n' | dedup | tr '\n' ':'`
  PATH=`echo ${PATH%?}`
}

isNotInPath() {
    # Grep's -q switch is not present on Solaris 8.
    echo $PATH | grep -v "$1" > /dev/null
}

UNAME_S=`uname -s`
if [ "$UNAME_S" != "SunOS" ] && [ "$UNAME_S" != "OpenBSD" ]
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
unset topDir
unset binDir
unset subDir
unset UNAME_S

