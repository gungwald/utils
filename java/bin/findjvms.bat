@echo off

rem //////////////////////////////////////////////////////////////////////////
rem 
rem     Program:     findjava
rem
rem     Description: Searches for Java JRE folders. This finds the JDK also
rem                  because there is a jre folder inside every JDK.
rem                  
rem     Author:      Bill Chatfield <bill_chatfield@yahoo.com>
rem 
rem //////////////////////////////////////////////////////////////////////////

setlocal enabledelayedexpansion
if "%~1"=="" (
    rem If no start directory was provided on the command line, then search 
    rem all drives.
    call :searchAllDrives
) else (
    rem Look for the "help" switch.
    if "%~1"=="/?" (
        echo Usage: %~n0 [start-in-folder]
    ) else (
        rem Search from all directories given on the command line.
        for %%a in (%*) do (
            call :findJavaFromDir %%a
        )
    )
)
endlocal
call :pauseForGUI
goto :EOF
rem END OF PROGRAM


rem //////////////////////////////////////////////////////////////////////////
rem
rem Loops over all logical drives looking for Java.
rem
rem //////////////////////////////////////////////////////////////////////////

:searchAllDrives

rem ///////////////////////////////////
rem Three methods:
rem 1. Loop over possible drive letters
rem 1. wmic logicaldisk
rem 2. Use WSH?
rem ///////////////////////////////////

rem This works in Wine. Don't change the syntax unless you test it in Wine!
set /a totalJreCount=0
wmic logicaldisk 1>NUL 2>NUL
if %ERRORLEVEL%==0 (
	for /f "skip=1" %%d in ('wmic logicaldisk where DriveType^=3 get Caption') do (
	    if not "%%d"=="" (
	        call :findJavaFromDir %%d\
	        set /a totalJreCount+=!ERRORLEVEL!
	    )
	)
) else (
    for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		if exist %%d:\\nul (
	        call :findJavaFromDir %%d:\
	        set /a totalJreCount+=!ERRORLEVEL!
	    )
	)
)

rem
rem Print the final summary of what was found.
rem
if !totalJreCount!==0 (
    echo Java was not found on any drive.
) else (
    echo Total Java installations found on all drives: !totalJreCount!
)
rem Return from searchAllDrives
exit /b 0


rem //////////////////////////////////////////////////////////////////////////
rem
rem Searches recursively for a directory named "jre" starting at root of 
rem drive specified by the first argument: %1. Returns the number of JRE 
rem instances found.
rem
rem If the "jre" directory contains a "bin\java.exe" then we found a Java
rem installation. Print out the info.
rem
rem This finds JDK installations because every JDK contains a "jre"
rem subdirectory.
rem
rem This method of searching for the "jre" directory prevents duplicates
rem that would occur if "java.exe" was searched for because each JDK
rem installation containes two "java.exe" files.
rem
rem //////////////////////////////////////////////////////////////////////////

:findJavaFromDir

set startDir=%1
set /a jreCount=0
if not defined startDir (
    exit /b !jreCount!
)
echo Searching for Java from directory %startDir%
rem This "pushd" makes it work in Wine's cmd.exe
pushd %startDir%
for /d /r %%j in (*jre*) do (
    set javaExe=%%j\bin\java.exe
    if exist "!javaExe!" (
        set /a jreCount+=1
        echo ----------------------------------------------------------------------------
        echo Found Java: !javaExe!
        "!javaExe!" -version
        echo ...Continuing search...
    )
)
popd
echo ----------------------------------------------------------------------------
if !jreCount!==0 (
    echo Java was not found in !startDir!
) else (
    echo Total Java installations found in !startDir! is !jreCount!
)
rem Return from findJavaFromDir
exit /b !jreCount!


rem //////////////////////////////////////////////////////////////////////////
rem
rem If this batch file was started by a double-click from Windows Explorer
rem or the Windows desktop, then pause so that the window doesn't disappear
rem before the user can read the output. If this batch file was run from
rem the Command Prompt, then don't pause.
rem
rem //////////////////////////////////////////////////////////////////////////

:pauseForGUI

for /f "tokens=2" %%i in ("%CMDCMDLINE%") do (
    if "%%i"=="/c" (
        pause
    )
)
rem Return from pauseForGUI
exit /b 0

