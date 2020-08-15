@echo off

rem Automatically finds run target in standard dev and production locations.
rem
rem Set DEBUG to any value to visualize the code flow.

setlocal enabledelayedexpansion

rem This is the only variable that should need to be configured.
set WORKSPACE=%USERPROFILE%\IBM\rationalsdp\workspace

set DEV_DIR=%WORKSPACE%\%~n0
set PGM=%~n0

rem Top-level search directories
for %%t in ("%DEV_DIR%" "%~dp0" "C:\opt\IBM\WCDE_ENT70\workspace\%~n0" "%USERPROFILE%\OneDrive\src\%PGM%") do (

    rem Avoid running unnecessary code.
    if exist %%t (

        rem Remove a trailing backslash if it exists.
        set TOP=%%~t
        if !TOP:~-1!==\ (
            set TOP=!TOP:~0,-1!
        )

        rem Subdirectories of each top-level directory to search
        for %%s in ("" ".." "classes" "..\classes" "bin" "..\bin") do (

            rem Append subdirectory to top-level directory.
            if %%s=="" (
                set DIR=!TOP!
            ) else (
                set DIR=!TOP!\%%~s
            )
            
            rem Avoid running unnecessary code.
            if exist "!DIR!" (

                rem Check for a .class file.
                set CLS_FILE=!DIR!\%PGM%.class
                if defined DEBUG echo DEBUG: Looking for !CLS_FILE!
                if exist "!CLS_FILE!" (
                    rem Find proper case of main class name so that Java will
                    rem find it at run-time.
                    for /f %%c in ('dir /b "!CLS_FILE!"') do (
                        set PGM=%%c
                        rem Remove .class extension leaving just the class 
                        rem name.
                        set PGM=!PGM:.class=!
                        set CLS_FILE=!DIR!\!PGM!.class
                    )
                    if defined DEBUG echo DEBUG: Found !CLS_FILE!
                    goto :RUN_CLASS
                )

                rem Check for a .jar file.
                set JAR=!DIR!\%PGM%.jar
                if defined DEBUG echo DEBUG: Looking for !JAR!
                if exist "!JAR!" (
                    if defined DEBUG echo DEBUG: Found !JAR!
                    goto :RUN_JAR
                )
            )
        )
    )
)

echo ERROR: neither %PGM%.class nor %PGM%.jar could be found.
goto :EOF

:RUN_CLASS
title java -cp "%DIR%" %PGM% %*
if defined DEBUG echo DEBUG: Starting: java -cp "%DIR%" %PGM% %*
java -cp "%DIR%" %PGM% %*
goto :END

:RUN_JAR
title java -jar "%JAR%" %*
if defined DEBUG echo DEBUG: Starting: java -jar "%JAR%" %*
java -jar "%JAR%" %*
goto :END

rem This code is not needed but it contains an idea that I don't want to lose.
if %PGM:~0,1% LSS a (
    echo WARNING: "%PGM%" must match case with main class or load will fail.
)

:END
title Command Prompt
endlocal

