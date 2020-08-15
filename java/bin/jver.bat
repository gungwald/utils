@echo off
for /f "tokens=3" %%v in ('java -version 2^>^&1') do (
    echo %%~v
    goto :EOF
)

