@echo off

set PATH=C:\mingw\bin;%PATH%
set CLASSPATH=c:\mingw\share\java\libgcj-3.4.5.jar

gcj -dumpversion
where gcj
where gij
echo CLASSPATH=%CLASSPATH%
