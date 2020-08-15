@echo off

set /p GROUP_ID=Enter groupId [Ex: com.cardinalhealth.bdcoe]: 
set /p ARTIFACT_ID=Enter atrifactId [Ex: table-metadata-import-tool]:

mvn archetype:generate -DgroupId="%GROUP_ID%" -DartifactId="%ARTIFACT_ID%" ^
-DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
