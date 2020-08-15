@echo off

setlocal EnableDelayedExpansion

rem
rem Lists certificates in the keystore for the Java instance defined by JAVA_HOME.
rem

set PROGRAM_NAME=%~n0

if not defined JAVA_HOME (

    call :msg The environment variable JAVA_HOME must be set.

) else (

    rem The path to the keystore in a JDK installation is different from 
    rem the path in a JRE installation. The JDK has a "jre" subdirectory.
    
    if exist "%JAVA_HOME%\jre" (
        set KEYSTORE=%JAVA_HOME%\jre\lib\security\cacerts
    ) else (
        set KEYSTORE=%JAVA_HOME%\lib\security\cacerts
    )

    call :msg Using keystore !KEYSTORE!.
    echo.

    "%JAVA_HOME%\bin\keytool" -list ^
        -keystore "!KEYSTORE!" ^
        -storepass changeit
)

endlocal

rem Pause only if started from the desktop.
for /f "tokens=2" %%a in ("%CMDCMDLINE%") do (
    if "%%a"=="/c" (
        echo.
        pause
    )
)

rem This is the end. My only friend, the end.
goto :EOF

rem Subroutine to print a message.
:msg
    echo %PROGRAM_NAME%: %*
    exit /b
 
