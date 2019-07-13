@echo off

rem
rem The "Documents" directory is used in Windows Vista and above.
rem The "My Documents" directory is used in Windows XP and below.
rem

rem Undefine variable MY which is local to this setlocal/endlocal block.
set MY=

for %%m in ("%USERPROFILE%\OneDrive - Cardinal Health 1" "%USERPROFILE%\Documents" "%USERPROFILE%\My Documents") do (
    if exist %%m (
        set MY=%%m
        goto :FINISHED_FINDING_DOCUMENTS_DIRECTORY
    )
)
:FINISHED_FINDING_DOCUMENTS_DIRECTORY

if defined MY (
    rem Remove surrounding quotes.
    set MY=%MY:"=%
)

rem Check value of MY.
if defined MY (
    pushd %MY%
) else (
    echo Failed to find user's documents directory.
)

endlocal

