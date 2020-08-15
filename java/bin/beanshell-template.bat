@echo off

rem
rem Runs a BeanShell script by the same name as this file.
rem It finds the BeanShell jar file and target script rem first.
rem
rem This is implemented as a Batch file because:
rem + PowerShell is worthless because it is disabled by default on
rem   every Windows machine.
rem + Windows Script Host (VBS, JScript) may be disabled by an admin
rem   also.
rem

setlocal

set BAT_DIR=%~dp0
rem Remove the trailing backslash.
set BAT_DIR=%BAT_DIR:~0,-1%
set BAT_FILE=%~nx0
set TARGET_SCRIPT_NAME=%~n0
set WGET=%BAT_DIR%\wget.js
set INTERPRETER_JAR_URL=https://bintray.com/artifact/download/beanshell/Beanshell/org/apache-extras/beanshell/bsh/2.0b6/bsh-2.0b6.jar
set JAR_DIR=%USERPROFILE%\share\java
set DOWNLOADED_INTERPRETER_JAR=%JAR_DIR%\bsh-2.0b6.jar
set LANGUAGE=BeanShell
set LANGUAGE_EXTENSION=bsh
set INTERPRETER_MAIN=bsh.Interpreter

rem
rem If the BeanShell jar file is not in the CLASSPATH, then find it and add it.
rem 

echo %CLASSPATH% | findstr /r "bsh-[1-9][^;]*\.jar" > NUL:
if %ERRORLEVEL%==0 (
    set INTERPRETER_CLASSPATH=%CLASSPATH%
    echo Interpreter is already in the CLASSPATH.
) else (
    for %%d in ("%BAT_DIR%" "%BAT_DIR%\..\lib" "%JAR_DIR%" "%USERPROFILE%\Desktop" "%USERPROFILE%\Downloads" "%USERPROFILE%\lib" "%USERPROFILE%\Documents\lib" ) do (
        for /f %%b in ('dir /b /o:-d "%%~d\bsh-*.jar" 2^> NUL:') do (
            echo %BAT_FILE%: Using CLASSPATH: %%~d\%%b
            set INTERPRETER_CLASSPATH=%%~d\%%b
            goto :FOUND_INTERPRETER_JAR
        )
    )
)
echo %BAT_FILE%: %LANGUAGE% jar file not found.

if exist "%WGET%" goto :DOWNLOAD_INTERPRETER_JAR

rem
rem Create the wget.js download script.
rem

echo var Source = WScript.Arguments.Item(0); > "%WGET%"
echo var Target = WScript.Arguments.Item(1); >> "%WGET%"
echo var http = WScript.CreateObject('MSXML2.ServerXMLHTTP'); >> "%WGET%"
echo WScript.Echo("Source URL = " + Source); >> "%WGET%"
echo WScript.Echo("Target File = " + Target); >> "%WGET%"
echo http.open('GET', Source, false); >> "%WGET%"
echo http.send(); >> "%WGET%"
echo if (http.status == 200) { >> "%WGET%"
echo    var Stream = WScript.CreateObject('ADODB.Stream'); >> "%WGET%"
echo    Stream.Open(); >> "%WGET%"
echo    Stream.Type = 1; // adTypeBinary >> "%WGET%"
echo    Stream.Write(http.responseBody); >> "%WGET%"
echo    Stream.Position = 0; >> "%WGET%"
echo    var File = WScript.CreateObject('Scripting.FileSystemObject'); >> "%WGET%"
echo    if (File.FileExists(Target)) { >> "%WGET%"
echo        File.DeleteFile(Target); >> "%WGET%"
echo    } >> "%WGET%"
echo    Stream.SaveToFile(Target, 2); // adSaveCreateOverWrite >> "%WGET%"
echo    Stream.Close(); >> "%WGET%"
echo } >> "%WGET%"
echo else { >> "%WGET%"
echo    WScript.Echo("Download failed with HTTP code: " + http.status); >> "%WGET%"
echo } >> "%WGET%"

rem
rem Attempt to download interpreter jar file.
rem

:DOWNLOAD_INTERPRETER_JAR

if exist "%WGET%" (
    echo %BAT_FILE%: Downloading %LANGUAGE%...
    if not exist "%JAR_DIR%" mkdir "%JAR_DIR%"
    cscript //nologo "%WGET%" "%INTERPRETER_JAR_URL%" "%DOWNLOADED_INTERPRETER_JAR%"
    if exist "%DOWNLOADED_INTERPRETER_JAR%" (
        set INTERPRETER_CLASSPATH=%DOWNLOADED_INTERPRETER_JAR%
        goto :FOUND_INTERPRETER_JAR
    ) else (
        echo %BAT_FILE%: %LANGUAGE% jar download failed with code %ERRORLEVEL%.
    )
) else (
    echo %BAT_FILE%: Can't find %WGET% needed to download %LANGUAGE%. Giving up.
)
goto :EOF

:FOUND_INTERPRETER_JAR

rem
rem Find the target script.
rem

for %%d in ("%BAT_DIR%" "%BAT_DIR%\..\scripts" "%USERPROFILE%\git\scripts\scripts" "%USERPROFILE%\scripts" "%USERPROFILE%\Documents\scripts") do (
    if exist %%~d\%TARGET_SCRIPT_NAME%.%LANGUAGE_EXTENSION% (
        set TARGET_SCRIPT=%%~d\%TARGET_SCRIPT_NAME%.%LANGUAGE_EXTENSION%
        goto :FOUND_TARGET_SCRIPT
    )
)
echo %BAT_FILE%: %LANGUAGE% script not found: %TARGET_SCRIPT_NAME%.%LANGUAGE_EXTENSION%
goto :EOF

:FOUND_TARGET_SCRIPT

rem
rem Run the script.
rem

echo %BAT_FILE%: Running script: %TARGET_SCRIPT%
java -cp "%INTERPRETER_CLASSPATH%" %INTERPRETER_MAIN% "%TARGET_SCRIPT%" %*

endlocal

