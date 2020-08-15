#!/bin/sh
 
# ----------------------------------------------------------------------
# Reads package names from standard input and calls rpm to force them to
# update. dnf apparently can't do it.
# ----------------------------------------------------------------------
forceUpdatePackages() {
	# The last part of the condition makes sure the last line is read even if
	# it doesn't have a line terminator.
	while read PACKAGE_NAME || [[ -n "$PACKAGE_NAME" ]]
	do
		rpm -ivh --force "$PACKAGE_NAME"
	done
}

# ----------------------------------------------------------------------
# Reads input from standard input or from command line arguments.
# ----------------------------------------------------------------------
if [ $# -eq 0 ]
then
	forceUpdatePackages
else
	for ARG in "$@"
	do
		forceUpdatePackages < "$ARG"
	done
fi
