@echo off

if %WinVer% LEQ 5.1 (
    control schedtasks
) else (
    taskschd.msc
)

