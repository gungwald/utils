@echo off

rem This script is for the situation where an ignore entry is added to
rem .gitignore for something like .idea/ that needs to be kept locally
rem but the file or directory entries had already been added to Git and
rem should be removed from Git.

if "%1"=="" (
    set /p ARG=Remove what?
    git rm -r --cached "%ARG%"
) else (
    git rm -r --cached %*
)
