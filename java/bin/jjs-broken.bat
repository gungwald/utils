@echo off

rem Finds and executes jjs.exe passing along any command line parameters.
rem
rem Author: Bill Chatfield <bill_chatfield@yahoo.com>

setlocal

set JreKey=HKLM\SOFTWARE\JavaSoft\Java Runtime Environment
set JreKey32On64=HKLM\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment

set CurrentVersion=
set JavaHome=

for %%k in ("%JreKey%" "%JreKey32On64%") do (
    for /f "skip=2 tokens=3" %%v in ('reg query "%JreKey%" /v CurrentVersion') do (
        set CurrentVersion=%%v
        for /f "skip=2 tokens=2*" %%h in ('reg query "%%~k\%%~v" /v JavaHome') do (
            set JavaHome=%%i
            rem In C, C++, or Java this would be a "break" statement.
            goto :Found_Java
        )
    )
)

if not defined CurrentVersion (
    echo No Java.
    goto :END
)

if not defined JavaHome (
    echo Java MIA.
    goto :END
)

:Found_Java

if %CurrentVersion% LSS 1.8 (
    echo Inferior Java version.
    goto :END
)

"%JavaHome%\bin\jjs.exe" %*

:END
endlocal

