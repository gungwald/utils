#!/bin/sh

if [ $# -ne 1 ]
then
	echo Specify the disk image
	exit 1
fi

DISK_IMG="$1"

if [ `uname -s` = 'OpenBSD' ]
then
	# See "man fdc":
	# '0' = The floppy drive number, '0' is the first drive
	# 'F' = 720 KB format disk
	# 'c' = The partition specifier, 'c' is the whole disk
	# The above qualifiers are required to mount a 720KB disk
	doas dd if="$DISK_IMG" of=/dev/fd0Fc
fi
