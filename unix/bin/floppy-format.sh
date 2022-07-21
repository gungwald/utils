#!/bin/sh

if [ `uname -s` = 'OpenBSD' ]
then
	echo Low level formatting for 720KB...
	# See "man fdc":
	# '0' = The floppy drive number, '0' is the first drive
	# 'F' = 720 KB format disk
	# 'c' = The partition specifier, 'c' is the whole disk
	# The above qualifiers are required to mount a 720KB disk
	doas fdformat /dev/rfd0Fc

	echo Creating MS-DOS file system...
	doas newfs -t msdos -f 720 -L Made_On_BSD /dev/rfd0Fc
fi
