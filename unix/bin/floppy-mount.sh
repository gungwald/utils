#!/bin/sh

TARGET_DIR=$HOME/mnt

if [ ! -d "$TARGET_DIR" ]
then
	mkdir "$TARGET_DIR"
fi

if [ `uname -s` = 'OpenBSD' ]
then
	# See "man fdc":
	# '0' = The floppy drive number, '0' is the first drive
	# 'F' = 720 KB format disk
	# 'a' = The partition specifier, 'a' is the first partition
	# The above qualifiers are required to mount a 720KB disk
	doas mount -t msdos /dev/fd0Fa $HOME/mnt
fi
