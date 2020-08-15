@echo off

setlocal EnableDelayedExpansion

if "%1"=="" (
    echo Try again, dumb-ass.
    goto :EOF
)

set props=
for %%p in (%*) do (
    set props=!props! /c:"    %%p"
)

java -XshowSettings:properties -version 2>&1 | findstr /i %props%

endlocal

