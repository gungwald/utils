@echo off

setlocal

set TOP_DIR=%~dp0..
set JAR_DIR=%TOP_DIR%\lib
set SCRIPT_DIR=%TOP_DIR%\scripts

java -jar %JAR_DIR%\which.jar %*
goto :EOF

rem Alternative scripts and start methods:
perl %SCRIPT_DIR%\which.pl %*
jrunscript -cp %JAR_DIR%\sleep.jar -l sleep %SCRIPT_DIR%\which.sl %*

endlocal

