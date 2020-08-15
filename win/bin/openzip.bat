@echo off

rem
rem     Opens a zip file in the standard Windows CompressedFolder window 
rem     instead of whatever zip files might be associated with (7-zip).
rem

if "%1" equ "" (
    echo Please provide the name of a zip file on the command line.
) else (
    explorer "%1"
)

