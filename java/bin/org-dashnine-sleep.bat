@echo off

rem Find sleep.jar and then run any script provided on the command line.
rem If there is no script provided on the command line, the resulting
rem action will be that the sleep interactive interface will be started.
rem This is the correct thing to do.

setlocal enableDelayedExpansion

rem Determine the location of this script.
set BIN_DIR=%~dp0

rem Remove the trailing backslash.
set BIN_DIR=%BIN_DIR:~0,-1%

rem Determine top of UNIX-like directory hierarchy.
set TOP_DIR=%BIN_DIR%\..

rem This will be the path and directory of first argument which should be 
rem the sleep script to run. It may not exist also. That is OK.
set ARG1_DIR=%~dp1

rem Remove the trailing backslash.
if defined ARG1_DIR set ARG1_DIR=%ARG1_DIR:~0,-1%

rem Search for sleep.jar.
set SLEEP_JAR=sleep.jar
set ABS_SLEEP_JAR=
rem Don't put the directory list into a variable first because it won't work
rem like you think it will.
for %%D in ("." "%BIN_DIR%" "%TOP_DIR%\share\java" "%TOP_DIR%\lib" "%ARG1_DIR%" "%USERPROFILE%\lib" "%USERPROFILE%\Documents\lib" "%USERPROFILE%\git\gungwald-utils\lib") do (
    rem The "f" below removes any ".." elements in the path, resolving the
    rem path to its cannonical form.
    set TEST_ABS_SLEEP_JAR=%%~fD\%SLEEP_JAR%
    if exist "!TEST_ABS_SLEEP_JAR!" (
        rem It was found, so set our "output" value in the ABS_SLEEP_JAR
        rem variable.
        set ABS_SLEEP_JAR=!TEST_ABS_SLEEP_JAR!
        goto :END_OF_SLEEP_JAR_SEARCH
    )
)
:END_OF_SLEEP_JAR_SEARCH

rem Check if SLEEP_JAR was not found.
if defined ABS_SLEEP_JAR (
    echo Using %ABS_SLEEP_JAR%
) else (
    echo %~n0: Required file, %SLEEP_JAR%, could not be found. >&2
    goto :EOF
)

rem Finally, run the sleep script using the sleep.jar that was found.
java -jar "%ABS_SLEEP_JAR%" %* 

endlocal

