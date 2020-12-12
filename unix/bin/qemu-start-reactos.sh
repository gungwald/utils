#!/bin/sh

qemu-system-i386 -L . -m 256 -hda ~/reactos-hd.qcow2 -localtime \
	-serial file:reactos.log -soundhw ac97 \
	-net user,smb=/home/bill
