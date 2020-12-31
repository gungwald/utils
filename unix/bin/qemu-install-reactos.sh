#!/bin/sh
qemu-system-i386 -L . -m 256 -cdrom ~/Downloads/ReactOS-0.4.13.iso \
	-hda $HOME/var/reactos/reactos-hd.qcow2 -boot d \
	-serial file:$HOME/var/reactos/reactos.log -soundhw ac97
