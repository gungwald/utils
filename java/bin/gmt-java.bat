@echo off
set JAVA_TOOL_OPTIONS=
ibm-java -jar %~dp0..\lib\gmt.jar %*
goto :EOF
java -jar %~dp0..\lib\sleep.jar %~dp0..\scripts\%~n0.sl %*
