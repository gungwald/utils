@rem js.bat - This script starts the Rhino JavaScript interpreter,
@rem which is a scripting language for Java. The first argument is 
@rem assumed to be the script to run.
@rem

@echo off

@rem Check for a script argument.
if "%1" EQU "" (
    echo No script, nothing to do, so exiting.
    goto :EOF
)

@rem The "setlocal" statement makes all variables local to
@rem this script.
setlocal enabledelayedexpansion

@rem Get properties of this script file.
@rem The %~n0 value is the short file name without an 
@rem extension.
set myName=%~n0
@rem The %~dp0 value is the drive and full path including a 
@rem trailing backslash.
set myDir=%~dp0

@rem Locate directories containing the required resources.
set lib=%myDir%..\lib
set scriptsDir=%myDir%..\Scripts
set scriptFile=%1

@rem Build the classpath. The JavaScript interpreter js.jar
@rem and jregistry.jar need to be in the lib directory.
@rem For the "set" command inside the loop to work as we
@rem expect, we must have the "enabledelayedexpansion" parameter
@rem on "setlocal" above and the "!" in place of "%" for
@rem the variable expansion below.
set CLASSPATH=
for %%j in (%lib%\*.jar) do (
    set CLASSPATH=!CLASSPATH!;%%j
)
@rem Remove the leading semicolon.
set CLASSPATH=%CLASSPATH:~1%

@rem Needed for java to find jregistry's native dll.
set PATH=%PATH%;%lib%

@rem Increasing the stack size because of java.lang.StackOverflowError.
@rem The default, I think, is 1 megabyte, so I'm doubling it to 2
@rem megabytes.
set stackSize=-Xss2m

@rem Set Java system variable to name of the script we're calling
@rem so that we can access it from Rhino JavaScript which does not
@rem provide any means to do that otherwise.
set sysProps=-Dscript.file=%scriptFile% -Dscript.language=javascript

@rem Combine all Java command line arguments.
set javaOptions=%stackSize% %sysProps% -classpath "%CLASSPATH%"

@rem Build the new argument list after removing the first one which
@rem is the JavaScript file that will be run by the JavaScript
@rem interpreter.
set remainingArgs=
if "%2" NEQ "" (
    set /a argNum=1
    for %%a in (%*) do (
        if !argNum! GTR 1 (
            set remainingArgs=!remainingArgs! %%a
        )
        set /a argNum += 1
    )
    @rem Remove leading space. The remainingArgs variable must be defined
    @rem and contain a value for the below "set" command to work properly.
    if defined remainingArgs (
        set remainingArgs=!remainingArgs:~1!
    )
)

@rem Start the JavaScript interpreter with the script file and
@rem the remaining arguments.
@rem
@rem Since java is the last command in this script, its exit code 
@rem or "errorlevel" will also get returned by this script. This
@rem allows the caller of this script to determine if the
@rem important code worked or not.
@rem
@rem The "endlocal" statement below does not change the exit code.
java %javaOptions% org.mozilla.javascript.tools.shell.Main %scriptFile% %remainingArgs%

endlocal

@rem PURPOSE:
@rem
@rem The only purpose of this script is to invoke a Rhino, the
@rem JavaScript interpreter. This script should attempt to be 
@rem as invisible as possible, passing on all parameters and 
@rem passing back the exit code.
@rem
@rem RESPONSIBILITIES:
@rem
@rem 1. Set the CLASSPATH to contain all the required jars.
@rem 2. Start the Rhino JavaScript interpreter with the
@rem    first argument as the JavaScript file.
@rem 3. Pass all inputs (command line parameters) on to the
@rem    target JavaScript file.
@rem 4. Pass back all outputs (exit code of the JavaScript 
@rem    file) to our caller. The java command which starts
@rem    the target JavaScript file has to be the last
@rem    command in this script for the exit code to be
@rem    returned to the calling process. The "endlocal"
@rem    statement does not modify the exit code so it may
@rem    appear at the very end.
