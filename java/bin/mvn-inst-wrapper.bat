@echo off
setlocal
for %%j in ("%~dp0..\lib\bsh*.jar") do set BSH_JAR=%%j
set BSH_SCRIPT=%~dp0..\scripts\%~n0.bsh 
java -classpath "%BSH_JAR%" bsh.Interpreter %BSH_SCRIPT% %*
endlocal
