@echo off

setlocal
call openjdk-setup.bat
javac %1
if %ERRORLEVEL% EQU 0 java %~n1 %2 %3 %4
endlocal
