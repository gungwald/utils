@echo off
if not defined JAVA_HOME (
    echo JAVA_HOME is not set. And by the way, you suck. So try setting it first.
    goto :EOF
)
echo Making permanent: JAVA_HOME=%JAVA_HOME%
setx JAVA_HOME "%JAVA_HOME%"
