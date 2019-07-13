@echo off

setlocal

set sourceFiles=%1
set targetDir=%2

if not defined sourceFiles goto :usage
if not defined targetDir   goto :usage

rem If a directory is specified as the source, like you can in Linux,
rem try to correct the syntax for xcopy.

if exist %sourceFiles% (
    set sourceFiles=%sourceFiles%\*.*
)

xcopy /s /e %sourceFiles% %targetDir%

goto :EOF

:usage
echo Usage: %~n0 sourceFiles targetDir

endlocal
