#!/bin/sh
IFS=':'
for elem in $PATH
do
  if [ -d "$elem" ] && find -name '*'"$1"'*'
  then
    # shellcheck disable=SC2006
    IFS="`printf ' \t\n'`"
    printf "\n%s:\n\n" "$elem"
    (
      cd $elem || exit
      for pattern
      do
        ls *"$pattern"*
      done
    )
  fi
done
