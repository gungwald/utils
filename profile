#!/bin/sh

# Desc:Sets up PATH to include the bin directories of all
#      subdirectories of the specified top-level directory
#      that contain a profile file and are supported on
#      the current platform.

# Finds and removes all duplicate lines in a stream of lines (a pipeline)
# The lines don't have to be sorted because an associative array is used
# to keep track of which ones are printed..
dedup()
{
  # Magic awk one-liner - It goes something like this, I think...
  # 1. Look up the current line, $0, in the array, "visited".
  # 2. If it hasn't yet appeared in the input, the value will be 0 (false), or empty, which is also false
  # 3. Increment and print because of the ! (not) which makes the result true
  # 4. If it has appeared in the input, the value will be 1 (true), or non-empty which is also true
  # 5. Increment and don't print because the ! (not) which makes the result false
  awk '!visited[$0]++'
}

# Removes duplicate elements in $PATH
dedupPath() 
{
  # Pipeline explanation:
  # 1.Start a pipeline with the single line $PATH.
  # 2.Convert all colons into newlines/line-feeds.
  # 3.Send the lines through the "dedup" function to remove duplicate lines.
  # 4.Convert all newlines/line-feeds back to colons.
  PATH=`echo $PATH | tr ':' '\n' | dedup | tr '\n' ':'`
  # Remove the trailing colon. You can't say COE'LEN. You have to say
  # COE'LON, with the ending like the word "on", because that's how the
  # British say it. It's important. Just say the ending loud. You'll see.
  # MacOS 12.3.1's head command can't handle negative values so it can't
  # be used to remove the trailing coLON. The ${PATH%?} is POSIX and
  # works in every shell except old Bourne shells. It is also faster
  # than running an external process like 'head'.
  PATH=`echo ${PATH%?}`
}

# Determines if an absolute directory is not in $PATH
isNotInPath()
{
    # Grep's -q switch is not present on Solaris 8, so the unnecessary output is sent to /dev/null instead.
    echo "$PATH" | grep -v "$1" > /dev/null
}

# Removes empty elements in a generic line whose elements are separated by colons.
removeEmptyElements()
(
    # Remove empty entries in a PATH or MANPATH type variable by replacing
    # each instance of two consecutive colons by one colon.
    echo "$1" | sed s/::/:/g
)

# Removes empty elements in the PATH variable.
removeEmptyPathElements()
{
    PATH=`removeEmptyElements "$PATH"`
}

# ------------------------------------------
#
# Main
#
# ------------------------------------------

# Can't exit because could be called with a dot
if [ $# -eq 0 ]; then
  echo Usage: $0 absolute-directory-name
else
  topDir="$1"

  dedupPath

  # Loop through subdirectories putting their bin directories in the PATH if they're configured for it.
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
fi
