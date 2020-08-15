@echo off

if defined DEBUG echo %~n0: arguments=%*
if defined DEBUG echo %~n0: CMDCMDLINE=%CMDCMDLINE%

for /f "tokens=2" %%a in ("%CMDCMDLINE%") do (
    if defined DEBUG echo %~n0: arg=%%a
    if "%%a"=="/c" (
        if not "%1"=="" (
            echo %*
        )
        pause
    )
)

