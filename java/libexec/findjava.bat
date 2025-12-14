@echo off

:: findjava.bat, Created by Bill Chatfield

setlocal EnableDelayedExpansion

set TRUE=0
set FALSE=1

:: Clear java variable so we can tell later if we set it to something.
set FINAL_JAVA=

:: Check for java.exe in JAVA_HOME environment variable
if defined JAVA_HOME (
    set POSSIBLE_JAVA=!JAVA_HOME!\bin\java.exe
    if exist "!POSSIBLE_JAVA!" (
        "!POSSIBLE_JAVA!" -version
        if %ERRORLEVEL%==0 (
            set FINAL_JAVA=!POSSIBLE_JAVA!
	    echo Found in JAVA_HOME: !FINAL_JAVA!
            goto :FOUND
        )
    )
)

echo Java was not in JAVA_HOME environment variable.

:: Check for java in the PATH.
where java
if %ERRORLEVEL%==0 (
    set FINAL_JAVA=java
    echo Found in path
    goto :FOUND
)

echo Java was not in PATH environment variable.
rem "%USERPROFILE%\.jdks" "%ProgramFiles%" 
for %%d in ("%ProgramFiles(x86)%") do (
    call :findHighestJavaUnderDir %%d
    if !ERRORLEVEL!==!TRUE! (
	    echo Java was found
        goto :FOUND
    )
)

if not defined FINAL_JAVA (
    echo ERROR: Java not found. Please install it or set JAVA_HOME to your Java directory.
)
goto :END

:FOUND
for %%j in ("%FINAL_JAVA%") do set JAVA=%%~j
echo %JAVA%

:END
:: Set first argument to the result.
endlocal
goto :EOF
rem /////////////////////////////////////////////////////////////////////
rem 	END OF PROGRAM
rem /////////////////////////////////////////////////////////////////////

rem /////////////////////////////////////////////////////////////////////
rem 	Subroutine findHighestJavaFromDir
rem /////////////////////////////////////////////////////////////////////
:findHighestJavaUnderDir
set START_DIR=%~1
set FOUND_VERIFIED_JAVA=false
set VERIFIED_JAVA=
:: Find the highest version of Java. The last one set will be the highest
:: version because they're processed in alphabetic order.
for /r "%START_DIR%" %%j in (java.exe) do (
    set POSSIBLE_JAVA=%%j
    echo Checking !POSSIBLE_JAVA!
    if exist "!POSSIBLE_JAVA!" (
	    "!POSSIBLE_JAVA!" -version
	    if !ERRORLEVEL!==0 (
		set VERIFIED_JAVA=!POSSIBLE_JAVA!
		echo Instance: !VERIFIED_JAVA!
	    )
    )
)
if "%VERIFIED_JAVA%"=="" (
	set RTN=%FALSE%
) else (
	set RTN=%TRUE%
	set FINAL_JAVA="%VERIFIED_JAVA%"
)
exit /b %RTN%
rem /////////////////////////////////////////////////////////////////////
rem 	End Subroutine findHighestJavaFromDir
rem /////////////////////////////////////////////////////////////////////

