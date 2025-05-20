rem @echo off

setlocal

set THIS=%~n0
set THIS_DIR=%~dp0
set LIB_DIR=%THIS_DIR%..\lib

rem Find the highest version of the jar.
rem May fail if there are spaces in LIB_DIR. Not sure how to solve it
rem because quotes also cause it to fail.
set JAR=
for %%j in (%LIB_DIR%\%THIS%-*.jar) do (
	set JAR=%%j
)

if exist "%JAR%" (
	java -jar "%JAR%" 
) else (
	echo No %THIS% jar file found in %LIB_DIR%.
)
endlocal