@echo off

:: findjava.bat, Created by Bill Chatfield

setlocal EnableDelayedExpansion

:: Clear java variable so we can tell later if we set it to something.
set java=

:: Check for java.exe in JAVA_HOME\bin
if defined JAVA_HOME (
    set possibleJava=!JAVA_HOME!\bin\java.exe
    if exist "!possibleJava!" (
        set java=!possibleJava!
        goto :end
    )
)

:: Check for java in the PATH.
where java
if %ERRORLEVEL%==0 (
    set java=java
    goto :end
)

:: Find the highest version of Java. The last one set will be the highest 
:: version because they're processed in alphabetic order.
for /d %%j in ("C:\Program Files (x86)\Java\jre*" "C:\Program Files (x86)\Java\jdk*" "C:\Program Files\Java\jre*" "C:\Program Files\Java\jdk*") do (
    set possibleJava=%%j\bin\java.exe
    if exist "!possibleJava!" (
        set java=!possibleJava!
    )
)

if not defined java (
    echo ERROR: Java not found. Please install it or set JAVA_HOME to your Java directory.
)

:end
:: Set first argument to the result.
endlocal & set "%~1=%java%

