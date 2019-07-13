@echo off

setlocal

if "%1"=="" (
    set /p UPSTREAM_URL=Enter upstream URL: 
) else (
    set UPSTREAM_URL=%1
)

git remote add origin %UPSTREAM_URL%

if %ERRORLEVEL%==0 (
    echo Done!
    echo Now use: git push -u origin master
)

endlocal

