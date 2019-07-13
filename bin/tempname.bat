@echo off

rem **********************************************************************
rem
rem Generates a unique temperary file name. The return value is put into
rem the TEMPNAME environment variable.
rem
rem Bill.Chatfield
rem 2008-11-20
rem
rem **********************************************************************

if "%1"=="" (
    set PREFIX=Temp-File
) else (
    set PREFIX=%1
)

set TRYCOUNT=0

:GENERATE_TEMPNAME
call timestamp
set TEMPNAME=%TEMP%\%PREFIX%-%TIMESTAMP%-%RANDOM%.tmp
if exist %TEMPNAME% (
    if %TRYCOUNT% leq 9 (
        set /a TRYCOUNT=%TRYCOUNT% + 1
        goto GENERATE_TEMPNAME 
    ) else (
        TEMPNAME=tempname-algorithm-failed-%TIMESTAMP%-%RANDOM%.tmp
    )
)

rem
rem Clean up
rem
set PREFIX=
set TRYCOUNT=
