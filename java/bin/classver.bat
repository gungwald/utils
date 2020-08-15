@echo off
set binDir=%~dp0
set myName=%~n0
call "%binDir%..\libexec\runjar.bat" "%myName%.jar" %*
goto :EOF

:: This file is a template for running jar files. Just copy the file and
:: name the copy the same as the jar file you want to run. No changes need
:: to be made to the code or these comments.
::
:: Command line arguments are passed through to the jar file unchanged.
::
:: The jar file itself should be in the same directory as this script or
:: in one of these directories:
::
::      ..\lib
::      %USERPROFILE%\lib
::      %USERPROFILE%\Documents\lib
::
:: The script runjar.bat is required to be in the same directory as this
:: script.
::
:: This way of running jar files has these advantages:
:: 1) This script can be put into a directory in the PATH and easily
::    started from the command line.
:: 2) Duplication of code to intelligently start a Java program is
::    minimized. It is encapsulated in runjar.bat, of which there only
::    needs to be one copy.
:: 3) It allows the runnable jar files to be organized into a separate
::    directory than this script.
