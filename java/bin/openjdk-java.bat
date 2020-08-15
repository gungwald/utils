@echo off

setlocal
call openjdk-setup.bat
java %*
endlocal
