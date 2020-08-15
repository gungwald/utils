@echo off

rem Script:  add-to-pathext.bat
rem Author:  Bill Chatfield
rem License: GPL2

rem
rem Check for help argument.
rem
set ARG=%1
if defined ARG (
    set ARG=%ARG:H=h%
    set ARG=!ARG:?=h!
    set ARG=!ARG:/=-!
    set ARG=!ARG:--=-!
    set ARG=!ARG:~0,2!
    if !ARG!==-h (
        echo Usage: %~n0 [.ext]
        goto :EOF
    )
)

if "%1"=="" (
	echo Usage: %~n0 [.ext]
        goto :EOF
) else (
	set NEW_EXT=%~1
)

setlocal EnableDelayedExpansion

rem Retrieve the user's Path from the master environment.
set MY_PATHEXT=
for /f "skip=1 tokens=3*" %%p in ('reg query hkcu\Environment /v PathExt') do (
    set MY_PATHEXT=%%p %%q

    rem If it's already in the master environment then don't add it.
    echo !MY_PATHEXT! | find /i "%NEW_EXT%" > NUL:
    if !ERRORLEVEL! EQU 0 (
        echo Extension %NEW_EXT% already exists in the permanent Path variable.
    ) else (
        rem Add to user's master enviroment.
        setx Path "!MY_PATHEXT!;%NEW_EXT%"
        if ERRORLEVEL 1 (
            echo Setx command failed 1>&2
            exit 1
        )
        echo Added extension %NEW_EXT% to permanent PathExt variable.
    )
)

rem If the user's Path doesn't exist yet, create it.
if not defined MY_PATHEXT (
    setx Path %NEW_EXT%
    if !ERRORLEVEL! NEQ 0 (
        echo Setx command failed 1>&2
        exit 1
    )
    echo Created permanent PathExt variable with extension %NEW_EXT%.
)

rem If it's already in the current environment then don't add it.
echo %PATHEXT% | find /i "%NEW_EXT%" > NUL:
if %ERRORLEVEL% EQU 0 (
    echo Extension %NEW_EXT% already exists in the PathExt variable.
    goto :EOF
)

endlocal

rem Add to current environment.
set PATHEXT=%PATHEXT%;%NEW_EXT%
echo Added extension %NEW_EXT% to PathExt in current environment.
set NEW_EXT=
