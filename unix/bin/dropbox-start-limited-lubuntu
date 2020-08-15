#!/bin/bash

function display() {
	echo $0: $* 1>&2
	# Using xmessage because it is installed by default on
	# Lubuntu. It has font problems but at least it works.
	# Zenity and notify-send would be other options but
	# they are not installed by default.
	xmessage -center $0: $*
}


# This requires the cpulimit to be installed via apt.
if ! which cpulimit
then
	display You must install cpulimit: sudo apt install cpulimit
	exit 1
fi

dropboxErrorFile=$(mktemp)

# On Lubuntu, the dbus-launch command is required to get the Dropbox
# system tray icon working correctly. Otherwise, the icon is a default
# "unknown" icon.
if ! dbus-launch \
	ionice -c 3 -n 7 \
	dropbox start -i && \
	cpulimit -b -e dropbox -l 10 2> "$dropboxErrorFile"
then
	display Failed to start dropblocks: $(cat $dropboxErrorFile)
fi

rm $dropboxErrorFile
