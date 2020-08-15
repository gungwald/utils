@echo off

setlocal EnableDelayedExpansion

if "%1"=="" (
    set SEARCH_DIR=%CD%
) else (
    set SEARCH_DIR=%1
)

echo Searching in %SEARCH_DIR%...

for /r %SEARCH_DIR% %%d in (core.*.dmp heapdump.*) do (
    choice /c ync /m "Delete %%~fd"

    if !ERRORLEVEL!==1 (
        rem The user selected 'Y', the first option.
        del %%~fd
        echo Deleted.
    ) else (
        if !ERRORLEVEL!==3 (
            rem The user selected 'C' for cancel, the third option.
            echo Canceling search, but can't interrupt loop evaluation.
            echo It could take a long time to complete, but it will
            echo do nothing. Thanks, Microsoft.
            goto :EOF
        ) else (
            echo Skipped.
        )
    )
    echo Continuing search.
)

endlocal

