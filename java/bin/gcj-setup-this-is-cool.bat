@echo off

rem Specify locations of 64-bit OpenJDK, MingW, and Jython.
set JAVA_HOME=C:\opt\thisiscool-gcc-4.3-ecj\gcc-ecj
set MINGW_HOME=C:\opt\thisiscool-gcc-4.3-ecj\gcc-ecj
set JY_HOME=C:\opt\jython2.5.3
set CLASSPATH=c:\opt\thisiscool-gcc-4.3-ecj\gcc-ecj\share\java\libgcj-4.3.0.jar

rem Set special path that doesn't conflick with other javas.
set PATH=%JAVA_HOME%\bin
set PATH=%PATH%;%MINGW_HOME%\bin
set PATH=%PATH%;%JY_HOME%\bin
set PATH=%PATH%;C:\Windows;C:\Windows\system32;%USERPROFILE%\Documents\bin

rem Remove this bugger becuase it's annoying at the command line.
set JAVA_TOOL_OPTIONS=

rem Setup the "make" command for MinGW.
echo @"C:\Program Files\mingw-w64\x86_64-5.1.0-posix-seh-rt_v4-rev0\mingw64\bin\mingw32-make.exe" %%* > %USERPROFILE%\Documents\bin\make.bat
