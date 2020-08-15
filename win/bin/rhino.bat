@echo off
setlocal enabledelayedexpansion
set MAIN_CLS=org.mozilla.javascript.tools.shell.Main
for %%j in ("%~dp0..\lib\*.jar") do set CLSPATH=!CLSPATH!;%%~j
java -Dscript.file="%1" -cp "%CLSPATH%" %MAIN_CLS% %*
endlocal
