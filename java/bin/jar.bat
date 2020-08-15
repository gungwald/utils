@echo off

rem
rem jar.bat, Created by Bill Chatfield
rem

setlocal EnableDelayedExpansion

rem
rem Check for JAVA_HOME pointing to a JDK containing jps.exe.
rem
if defined JAVA_HOME (
    if exist "!JAVA_HOME!" (
        echo !JAVA_HOME! | findstr /i jre > NUL:
        if !ERRORLEVEL!==0 (
            echo JAVA_HOME is set to a JRE, but a JDK is required. Searching for a JDK...
            goto :FIND_JAR
        )
        set JAR=!JAVA_HOME!\bin\jar.exe
        if exist "!JAR!" (
            goto :FOUND_JAR
        ) else (
            echo !JAR! is missing from the JDK specified by JAVA_HOME. Searching for another JDK...
        )
    ) else (
        echo JAVA_HOME points to a non-existent directory. Searching for another JDK...
    )
)

:FIND_JAR

rem
rem Find the highest version of the Java JDK. The last one set will
rem be the highest version because they're processed in alphabetic
rem order.
rem
set HIGHEST_JDK=
for /d %%j in ("C:\Program Files (x86)\Java\jdk*" "C:\Program Files\Java\jdk*") do (
    if exist "%%j\bin\jar.exe" (
        set HIGHEST_JDK=%%j
        set JAR=%%j\bin\jar.exe
    ) else (
        echo ERROR: JDK is missing jar.exe. It should be here: %%j\bin\jar.exe.
    )
)

if not exist HIGHEST_JDK (
    echo ERROR: JDK not found. Please install it or set JAVA_HOME to your JDK directory.
    goto :EOF
)

:FOUND_JAR

echo %~dpnx0: Using jar.exe at %JAR%

"%JAR%" %*

goto :EOF
rem This is the end of the main program. ":EOF" is a built-in label that
rem forwards to the end of the file and also runs "endlocal".

:HELP
echo.
echo.
echo.
echo    Usage: %~n0 [MainClassName1 [MainClassName2 ...]]
echo           %~n0 -help
echo.
echo    If no MainClassNames are provided, the kill list will be read from
echo    the environment variable DEFAULT_JKILL_LIST.
echo.
echo    The user will be asked for confirmation before applications are killed.
echo.
echo.
echo.

endlocal

