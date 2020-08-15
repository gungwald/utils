@echo off

rem Specify locations of 64-bit OpenJDK, MingW, and Jython.
set JAVA_HOME=C:\opt\openjdk-1.7.0-u80-unofficial-windows-amd64-image
set MINGW_HOME=C:\Program Files\mingw-w64\x86_64-5.1.0-posix-seh-rt_v4-rev0\mingw64
set JY_HOME=C:\opt\jython2.5.3

rem Set special path that doesn't conflick with other javas.
set PATH=%JAVA_HOME%\bin
set PATH=%PATH%;%MINGW_HOME%\bin
set PATH=%PATH%;%JY_HOME%\bin
set PATH=%PATH%;C:\Windows;C:\Windows\system32;%USERPROFILE%\Documents\bin

rem Remove this bugger becuase it's annoying at the command line.
set JAVA_TOOL_OPTIONS=

rem Setup the "make" command for MinGW.
echo @mingw32-make %%* > %USERPROFILE%\Documents\bin\make.bat
