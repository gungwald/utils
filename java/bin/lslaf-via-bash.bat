@echo off

rem Starts a bash script by the same name as this script, minus the
rem ".bat" extension. For example: thisscript.bat starts "bash thisscript".

rem Instead of building both a shell script and a batch file to run
rem Java programs, just build a shell script and use the Windows
rem version of bash to run it. That way only one script has to be
rem written.

setlocal

rem Avoid getting the user's home directory misdirected to a network
rem drive. This happens when connected to a corporate network.
if defined HOMEDRIVE (
    if %USERPROFILE:~0,2% NEQ %HOMEDRIVE% (
        set HOME=%USERPROFILE%
    )
)

set BASH=C:\Program Files\git\bin\bash.exe

if exist "%BASH%" (
    rem Run %~dpn0 which is our target bash script, passing along all
    rem parameters: %*. To understand this weird syntax, type "call /?"
    rem in a Command Prompt to get help on the call command, which
    rem explains the meaning of the syntax.
    "%BASH%" "%~dpn0" %*
) else (
    echo The script that starts this application requires the GNU
    echo Bourne-Again Shell a.k.a. bash. It is included in the download
    echo for the Git tool at https://git-scm.com/download/win.
    echo Starting the download now...
    start https://git-scm.com/download/win
)

endlocal

