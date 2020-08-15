@echo off

rem
rem jkill.bat, Created by Bill Chatfield
rem
rem Uses jps.exe from the JDK and taskkill.exe from Windows to kill all 
rem Java programs as specified on the command line by their main class name
rem as it appears in the jps.exe listing. A default kill list can also be set
rem below.
rem
rem Requirements:
rem     1. JDK 1.5 or above, which provides the required jps.exe program.
rem        The JRE does not include jps.exe so it will not work.
rem     2. JDK installed in default directory or JAVA_HOME set to the install
rem        directory.
rem

setlocal EnableDelayedExpansion

rem
rem User configurable variable: DEFAULT_JKILL_LIST
rem
rem Lists Java main class names to kill, as they appear in the jps.exe
rem output. Any command-line arguments will override this default list.
rem This can be set outside the script or changed below.
rem

if not defined DEFAULT_JKILL_LIST (
    set DEFAULT_JKILL_LIST=CartsServiceApplication GradleDaemon
)

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

    rem There are command line arguments and the first one is not a help 
    rem switch so assign all of them to kill list.
    set JKILL_LIST=%*
) else (
    rem There are no command line arguments, so use the default kill list.
    set JKILL_LIST=%DEFAULT_JKILL_LIST%
)

rem
rem Check for JAVA_HOME pointing to a JDK containing jps.exe.
rem
if defined JAVA_HOME (
    if exist "!JAVA_HOME!" (
        echo !JAVA_HOME! | findstr /i jre > NUL:
        if !ERRORLEVEL!==0 (
            echo JAVA_HOME is set to a JRE, but a JDK is required. Searching for a JDK...
            goto :FIND_JPS
        )
        set JPS=!JAVA_HOME!\bin\jps.exe
        if exist "!JPS!" (
            goto :FOUND_JPS
        ) else (
            echo !JPS! is missing from the JDK specified by JAVA_HOME. Searching for another JDK...
        )
    ) else (
        echo JAVA_HOME points to a non-existent directory. Searching for another JDK...
    )
)

:FIND_JPS

rem
rem Find the highest version of the Java JDK. The last one set will
rem be the highest version because they're processed in alphabetic
rem order.
rem
set HIGHEST_JDK=
for /d %%j in ("C:\Program Files (x86)\Java\jdk*" "C:\Program Files\Java\jdk*") do (
    if exist "%%j\bin\jps.exe" (
        set HIGHEST_JDK=%%j
        set JPS=%%j\bin\jps.exe
    ) else (
        echo ERROR: JDK is missing jps.exe. It should be here: %%j\bin\jps.exe.
    )
)

if not exist HIGHEST_JDK (
    echo ERROR: JDK not found. Please install it or set JAVA_HOME to your JDK directory.
    goto :EOF
)

:FOUND_JPS

rem echo Using jps.exe at %JPS%
set SOMETHING_MATCHED=false

rem
rem Start the killing...
rem 
rem Run %JPS%. Read each line in the output and determine if it is what needs
rem to be killed. If so, kill it.
rem

for /f "tokens=1,2 usebackq" %%p in (`"%JPS%"`) do (

    rem %%p will be the process id.
    rem %%q will be the process main class name.
    
    for %%j in (!JKILL_LIST!) do (
        if %%q==%%j (
            set SOMETHING_MATCHED=true
            choice /c ync /m "Kill '%%q' which has PID of %%p"
            if !ERRORLEVEL!==1 (
                rem The user selected 'Y', the first option.
                echo Killing %%q which has PID of %%p
                taskkill /pid %%p /f
            ) else (
                if !ERRORLEVEL!==3 (
                    rem The user selected 'C' for cancel, the third option.
                    goto :EOF
                )
            )
            rem If the user selects 'N' we do nothing and contine the loop.
        )
    )
)

if %SOMETHING_MATCHED%==false (
    echo No running programs match with kill list: %JKILL_LIST%
    echo Use "%~n0 -help" for documentation.
)

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

