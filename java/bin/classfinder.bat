@echo off

rem Starts an application jar file which is named the same as this script,
rem with an optional version number: scriptname.jar or scriptname-1.0.jar.
rem A search is done for the jar using likely locations, starting with
rem the same directory that this script is in.

setlocal

set APP_NAME=%~n0
set SAME_DIR=%~dp0

rem Remove the trailing backslash.
set SAME_DIR=%SAME_DIR:~0,-1%

rem Find application jar.
rem DO NOT try to put the search directories in a variable first because
rem then any space inside an individual directory will cause the directory
rem to get split into separate words. Putting the list in the "for" loop
rem allows the spaces in directory names to be preserved with the double-quotes
rem around each variable.
rem This list, along with the "goto" also establishes a priority.
set APP_JAR=
for %%d in ("%SAME_DIR%" "%SAME_DIR%\..\lib" "%USERPROFILE%\git\%APP_NAME%\build\libs" "%USERPROFILE%\lib" "%USERPROFILE%\Documents\lib" "%USERPROFILE%\Dropbox\lib") do (
    for %%j in ("%%~d\%APP_NAME%.jar" "%%~d\%APP_NAME%-*.jar") do (
        if exist %%j (
            rem Don't break here because we want to get the higest version 
            rem jar file.
            set APP_JAR=%%j
        )
    )

    rem Stop searching if we found the highest version in this search dir %%d.
    if defined APP_JAR (
        goto :END_OF_SEARCH
    )
)

:END_OF_SEARCH

rem Check for failure to find the application jar.
if not defined APP_JAR (
    echo %~nx0: The application jar file was not found in any known location. >&2
    goto :EOF
)
echo Using %APP_JAR%.

set SYSTEM_PROPS=-Dswing.defaultlaf=com.sun.java.swing.plaf.windows.WindowsLookAndFeel

start javaw %SYSTEM_PROPS% -jar "%APP_JAR%" %*

endlocal

