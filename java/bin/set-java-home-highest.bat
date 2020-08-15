@echo off

set PFJDK=C:\Program Files\Java\jdk*
set PFJRE=C:\Program Files\Java\jre*
set PF86JDK=C:\Program File (x86)\Java\jdk*
set PF86JRE=C:\Program File (x86)\Java\jre*

set JAVA_HOME=
for /d %%d in ("%PF86JRE%" "%PF86JDK%" "%PFJRE%" "%PFJDK%") do (
    echo Found: %%d
    set JAVA_HOME=%%d
)

if defined JAVA_HOME echo Final setting: %JAVA_HOME%

if not defined JAVA_HOME echo Java was not found anywhere. Please install it.

set PFJDK=
set PFJRE=
set PF86JDK=
set PF86JRE=

