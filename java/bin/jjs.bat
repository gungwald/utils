@echo off

rem
rem jjs.bat, Created by Bill Chatfield
rem

setlocal EnableDelayedExpansion

rem
rem Check for command line arguments.
rem
set ARG=%1
if defined ARG (
    set ARG=%ARG:H=h%
    set ARG=!ARG:?=h!
    set ARG=!ARG:/=-!
    set ARG=!ARG:--=-!
    set ARG=!ARG:~0,2!
    if !ARG!==-h goto :HELP
) else (
    echo Please provide the name of a script to run.
    goto :EOF
)

rem
rem Check for JAVA_HOME pointing to a JDK containing jjs.exe.
rem
if defined JAVA_HOME (
    if exist "!JAVA_HOME!" (
        echo !JAVA_HOME! | findstr /i jre > NUL:
        if !ERRORLEVEL!==0 (
            echo JAVA_HOME is set to a JRE, but a JDK is required. Searching for a JDK...
            goto :FIND_JJS
        )
        set JJS=!JAVA_HOME!\bin\jjs.exe
        if exist "!JJS!" (
            goto :FOUND_JJS
        ) else (
            echo !JJS! is missing from the JDK specified by JAVA_HOME. Searching for another JDK...
        )
    ) else (
        echo JAVA_HOME points to a non-existent directory. Searching for another JDK...
    )
)

:FIND_JJS

rem
rem Find the highest version of the Java JDK. The last one set will
rem be the highest version because they're processed in alphabetic
rem order.
rem
set HIGHEST_JDK=
for /d %%j in ("C:\Program Files (x86)\Java\jdk*" "C:\Program Files\Java\jdk*") do (
    if exist "%%j\bin\jjs.exe" (
        set HIGHEST_JDK=%%j
        set JJS=%%j\bin\jjs.exe
    ) else (
        echo ERROR: JDK is missing jjs.exe. It should be here: %%j\bin\jjs.exe.
    )
)

if not exist HIGHEST_JDK (
    echo ERROR: JDK not found. Please install it or set JAVA_HOME to your JDK directory.
    goto :EOF
)

:FOUND_JJS
rem echo Using jjs.exe at %JJS%
"%JJS%" "%1" 
goto :EOF
rem This is the end of the main program. ":EOF" is a built-in label that
rem forwards to the end of the file and also runs "endlocal".

:HELP
echo.
echo.
echo.
echo    Usage: %~n0 <script-name>
echo           %~n0 -help
echo.
echo.
echo.

endlocal

