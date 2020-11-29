#!/bin/sh
qemu-system-i386 -L . -m 256 \
    -hda $HOME/var/reactos/reactos-hd.qcow2 \
    -serial file:$HOME/var/reactos/reactos.log 
    #-soundhw ac97
