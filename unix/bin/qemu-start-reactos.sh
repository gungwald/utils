#!/bin/sh
#qemu-system-i386 -L . -m 1024 -cdrom ReactOS-0.4.13.iso -hda reactos-hd.img -boot d -localtime -serial file:reactos.log -soundhw ac97
qemu-system-i386 -L . -m 256 -hda ~/reactos-hd.qcow2 -localtime -serial file:reactos.log -soundhw ac97
