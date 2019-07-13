@echo off

set SEVENZ=C:\Program Files\7-Zip\7z.exe
set SEVENZ_FM=C:\Program Files\7-Zip\7zFM.exe

if "%1"=="" (
    "%SEVENZ_FM%"
    goto :EOF
)
    
if exist "%1" (
    for %%f in (%*) do "%SEVENZ_FM%" "%%f"
) else (
    "%SEVENZ%" %*
)

