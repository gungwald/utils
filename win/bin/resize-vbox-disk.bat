@echo off

rem     Argument %1 must be a .vdi file.

set MB=20000

vboxmanage modifyhd --resize=%MB% %1

set MB=
