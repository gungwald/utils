rem @echo off

rem Script:  add-to-path.bat
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
        echo Usage: %~n0 [directory]
    )
)

if "%1"=="" (
	set TARGET_DIR=%CD%
) else (
	if "%1"=="." (
		set TARGET_DIR=%CD%
	) else (
		set TARGET_DIR=%~1
	)
)

SetLocal EnableDelayedExpansion

reg query hkcu\Environment /v Path > NUL:
if %ERRORLEVEL% NEQ 0 goto :END_REGISTRY_QUERY

rem Retrieve the user's Path from the master environment.
rem Multiple iterations of the for loop are not needed. but the ability
rem to run a command and get the 3rd token of the output is needed.
set REG_USER_PATH=
for /f "skip=1 tokens=3*" %%p in ('reg query hkcu\Environment /v Path') do (

    rem Detect spaces in the Path.
    rem %%q is the token after %%p. It indicates that there is a space in the PATH
    rem TODO - Add support for any spaces in the PATH. It will probably
    rem require reimplementing in JScript/VBScript or God forbid, PowerShell.
    if "%%q"=="" (
        echo Verified that the user PATH in the registry has no spaces. Continuing...
    ) else (
        echo Detected spaces in user PATH in registry. Fix it. Aborting. 1>&2
        goto :EOF
    )

    set REG_USER_PATH=%%p

    rem Remove junk from the end of the path.
    :MORE_JUNK_AT_END_OF_PATH
        if "!REG_USER_PATH:~-1!"==" " (
            set REG_USER_PATH=!REG_USER_PATH:~0,-1!
            goto :MORE_JUNK_AT_END_OF_PATH
        )
        if "!REG_USER_PATH:~-1!"==";" (
            set REG_USER_PATH=!REG_USER_PATH:~0,-1!
            goto :MORE_JUNK_AT_END_OF_PATH
        )


    rem If it's already in the master environment then don't add it.
    echo !REG_USER_PATH! | find /i "%TARGET_DIR%" > NUL:
    if !ERRORLEVEL! EQU 0 (
        echo Directory %TARGET_DIR% already exists in the permanent Path variable.
    ) else (
        rem Add to user's master environment.
        setx Path "!REG_USER_PATH!;%TARGET_DIR%"
        if !ERRORLEVEL! NEQ 0 (
            echo Setx command failed 1>&2
            goto :END
        )
        echo Added directory %TARGET_DIR% to permanent Path variable.
    )
)
:END_REGISTRY_QUERY

rem If the user's Path doesn't exist yet, create it.
if not defined REG_USER_PATH (
    setx Path %TARGET_DIR%
    if !ERRORLEVEL! NEQ 0 (
        echo Setx command failed 1>&2
        goto :END
    )
    echo Created permanent Path variable with directory %TARGET_DIR%.
)

rem If it's already in the current environment then don't add it.
echo %PATH% | find /i "%TARGET_DIR%" > NUL:
if %ERRORLEVEL% EQU 0 (
    echo Directory %TARGET_DIR% already exists in the Path.
    goto :END
)

:END
EndLocal

rem Add to current environment.
set PATH=%PATH%;%TARGET_DIR%
echo Added directory %TARGET_DIR% to Path in current environment.
set TARGET_DIR=
