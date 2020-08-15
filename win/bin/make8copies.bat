rem @echo off

setlocal enabledelayedexpansion
set NUMBER_OF_COPIES=8

rem Process all lines of output from command. Each line is expected
rem to contain a file name which will be assigned to the variable %%o
rem for "original" file.
for /f %%o in ('%~dp0File_Chooser_Component.bat') do (

    rem Derive needed info from variable %%o.
    set ORIGINAL=%%~fo
    set TARGET_BASE_NAME=%%~dpno
    set EXTENSION=%%~xo
    
    rem Loop from 1 to %NUMBER_OF_COPIES% with an increment of 1.
    for /l %%i in (1,1,%NUMBER_OF_COPIES%) do (
        copy "!ORIGINAL!" "!TARGET_BASE_NAME!_%%i!EXTENSION!"
    )
)
endlocal