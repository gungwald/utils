@echo off

setlocal

call setvars.bat
jrunscript -cp %JAR_DIR%\sleep.jar -l sleep %SCRIPT_DIR%\which.sl %*
goto :EOF

rem Alternative scripts and start methods:
perl %SCRIPT_DIR%\which.pl %*
java -jar %JAR_DIR%\sleep.jar %SCRIPT_DIR%\which.sl %*

endlocal

