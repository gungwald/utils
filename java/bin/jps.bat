@echo off

rem Optimal command line: jps -lm | sort

setlocal

rem Find the highest version of the Java JDK. The last one set will
rem be the highest version because they're processed in alphabetic
rem order.
for /d %%j in ("C:\Program Files (x86)\Java\jdk*" "C:\Program Files\Java\jdk*") do set HIGHEST_JDK=%%j

if "%HIGHEST_JDK%"=="" (
    echo ERROR: No JDK found.
    goto EOF:
)

set JPS=%HIGHEST_JDK%\bin\jps.exe

if exist "%JPS%" (
    "%JPS%" %*
) else (
    echo ERROR: "%JPS%" is missing.
)

endlocal

