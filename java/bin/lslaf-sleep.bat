#!/bin/sh

set BIN_DIR=%~pd0
set MY_NAME=%~n0

if exist "%BIN_DIR%"\sleep.jar (
    rem All files are in the same directory.
    set LIB_DIR="%BIN_DIR%"
    set SCRIPTS_DIR="%BIN_DIR%"
) else (
    rem Files are separated into bin, lib, and scripts directories.
    set TOP_DIR="%BIN_DIR%"\..
    set LIB_DIR="%TOP_DIR%"\lib
    set SCRIPTS_DIR="%TOP_DIR%"\scripts
)

set SYSTEM_PROPS=

java %SYSTEM_PROPS% -jar "%LIB_DIR%"\sleep.jar "%SCRIPTS_DIR%"\"%MY_NAME%" %*

