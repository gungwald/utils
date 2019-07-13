@echo off

set PATH=%PATH%;C:\Program Files\qemu
set DOCDIR=%USERPROFILE%\Documents
set VARDIR=%DOCDIR%\var
set HD=%VARDIR%\centos.qcow
set CD=%USERPROFILE%\Downloads\CentOS-7-x86_64-Minimal-1503-01.iso
set QEMU=qemu-system-x86_64

if not exist %VARDIR% mkdir %VARDIR%
if not exist %HD% (
    rem Setup and install

    rem Create the system disk.
    qemu-img create %HD% 32G

    echo Start an emulation session to run the install from CD to HD.
    %QEMU% -cdrom %CD% -hda %HD% -boot d -net nic -net user -m 2G -localtime
)

rem Run the guest OS normally
%QEMU% %HD% -boot c -net nic -net user -m 2G -localtime
