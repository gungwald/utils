@echo off
set MAX_VOLUME=65535
set /a VOLUME_LIMIT=%MAX_VOLUME% / 10
C:\opt\nircmd\nircmd.exe setsysvolume %VOLUME_LIMIT%

