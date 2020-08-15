@echo off

setlocal

rem Find directories
set THIS_DIR=%~dp0
rem The trailing backslash has to be removed or the next for statement
rem doesn't get the parent directory.
set THIS_DIR=%THIS_DIR:~0,-1%
for %%P in ("%THIS_DIR%") do set PARENT_DIR=%%~dpP
set LIB_DIR=%PARENT_DIR%lib
set SCRIPT_DIR=%PARENT_DIR%scripts

rem Find components
for %%J in ("%LIB_DIR%"\bsh*.jar) do set BEANSHELL_JAR=%%J
set BEANSHELL_SCRIPT=%SCRIPT_DIR%\%~n0.bsh

rem Engage...
java -classpath "%BEANSHELL_JAR%" bsh.Interpreter "%BEANSHELL_SCRIPT%" %*

endlocal

