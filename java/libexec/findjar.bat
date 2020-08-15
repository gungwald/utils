@echo off

rem /////////////////////////////////////////////////////////////////////////
rem
rem CONTRACT (Needs updated)
rem
rem Command line args:  (required) the name of one jar file, just the name,
rem                     no path
rem Standard input:     Ignored
rem Standard output:    The full path and name of the jar file, if it is
rem                     found, nothing if it is not found
rem Standard error:     Any error messages or nothing if there were no errors
rem Environment vars:   None are changed
rem Return value:       0
rem
rem /////////////////////////////////////////////////////////////////////////

setlocal

set jarName=%~1

if not defined jarName (
    echo The name of the jar file to find is required as a command line argument.
    goto :EOF
)

:: Determine the directory this script is in and then remove the trailing
:: backslash.
set binDir=%~dp0
set binDir=%binDir:~0,-1%

rem DO NOT try to put the search directories in a variable first because
rem then any space inside an individual directory will cause the directory
rem to get split into separate words. Putting the list in the "for" loop
rem allows the spaces in directory names to be preserved with the double-quotes
rem around each variable.
set jar=
for /d %%d in ("%binDir%" "%binDir%\..\lib" "%USERPROFILE%\lib" "%USERPROFILE%\Documents\lib" "%USERPROFILE%\Dropbox\lib") do (
    set potentialJarLocation=%%~d\%jarName%
    if defined DEBUG echo Checking potentialJarLocation=!potentialJarLocation!
    if exist "!potentialJarLocation!" (
        set jar=!potentialJarLocation!
        goto :searchComplete
    )
)
:searchComplete

rem Check for failure to find the application jar.
if not defined jar (
    echo ERROR: The application jar file %jarName% was not found in any known location. >&2
)

if defined DEBUG echo %~n0: Returning value jar=%jar%

:: Pass return value back in command line argument #2.
endlocal & set "%~2=%jar%"

