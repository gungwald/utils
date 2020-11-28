#!/bin/sh
qemu-system-i386 -L . -m 256 -cdrom ~/Downloads/ReactOS-0.4.13.iso \
	-hda ~/reactos-hd.qcow2 -boot d -localtime \
	-serial file:reactos.log -soundhw ac97
