@echo off

rem This can be done with the "where" command. So this was kind of
rem a waste of time.

rem Allow variable values to update inside "for" & "if" statements.
setlocal EnableDelayedExpansion
rem Interpret each command line argument as a search pattern, %%p.
for %%p in (%*) do (
    rem Quote each PATH entry and separate them by spaces.
    rem Loop over the entries, assigning each one to %%d.
    for %%d in ("%PATH:;=" "%" "%CD%") do (
        rem Skip directories in PATH that do not exist
        if exist %%d (
            pushd %%d
            rem Get all files in directory %%d, matching the pattern %%p.
            for /f "delims=" %%m in ('dir /b *%%p* 2^> NUL:') do (
                echo %%~dpnm
            )
        )
    )
)
rem End of local variable scope
endlocal
