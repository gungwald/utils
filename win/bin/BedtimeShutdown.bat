@echo off
setlocal
set TIMEOUT_SECONDS=15
set COMMENT="It is bedtime. Save your work NOW or lose it!"
shutdown /s /t %TIMEOUT_SECONDS% /d p:00:00 /c %COMMENT%
endlocal
