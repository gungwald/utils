@echo off
setlocal
for %%j in ("%~dp0..\lib\bsh*.jar") do set BSH_JAR=%%j
set BSH_SCRIPT=%~dp0..\scripts\%~n0.bsh 
java -classpath "%BSH_JAR%" bsh.Interpreter %BSH_SCRIPT% %*
endlocal




rem //////////////////////////////////////////////
rem Skip over old code, but keep it for reference.
rem //////////////////////////////////////////////
goto :EOF

set /p GROUP_ID=Group id formatted like com.company.group.name:
set /p ARTIFACT_ID=Artifact id formatted like my-component-name:

mvn archetype:generate ^
    -DgroupId=%GROUP_ID% ^
    -DartifactId=%ARTIFACT_ID% ^
    -DarchetypeArtifactId=maven-archetype-webapp ^
    -DinteractiveMode=false
