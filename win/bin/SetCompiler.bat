@echo off

rem
rem     Compiler switcher
rem

rem
rem     Reset
rem
set INCLUDE=
set LIB=
rem     Used by g95
set LIBRARY_PATH=

if "%1"=="" goto noarg
if "%1"=="microsoft" goto microsoft
if "%1"=="borland" goto borland
if "%1"=="gcc" goto gcc
if "%1"=="watcom" goto watcom

:noarg
echo Please provide one of: microsoft, borland, gcc, watcom.
goto end

rem
rem     Microsoft C Compiler
rem
:microsoft
call "C:\Program Files\Microsoft Visual Studio 8\VC\vcvarsall.bat"
call "C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\SetEnv.cmd"
goto end

rem
rem     Borland C Compiler
rem
:borland
set PATH=C:\opt\borland\bcc55\bin;%PATH%
goto end

rem
rem     GNU C Compiler
rem
:gcc
set PATH=C:\opt\MinGW\bin;%PATH%
goto end

REM
REM     Watcom C Compiler
REM
:watcom
set PATH=C:\opt\WATCOM\BINNT;C:\opt\WATCOM\BINW;%PATH%
SET INCLUDE=C:\opt\WATCOM\H;C:\opt\WATCOM\H\NT
SET WATCOM=C:\opt\WATCOM
SET EDPATH=C:\opt\WATCOM\EDDAT

:end
