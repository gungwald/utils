@echo off

setlocal
call openjdk-setup.bat
javac %*
endlocal
