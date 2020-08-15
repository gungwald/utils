rem @echo off

rem setlocal can't be used because we need to change PATHEXT.

rem Parameters
set EXTENSION=.jy
set FILE_TYPE=JythonScript
set COMMAND=%COMSPEC% /c jython ^"%%1^" %%*

rem This usage of "assoc" requires Administrator access rights.
assoc %EXTENSION%=%FILE_TYPE%

if not %ERRORLEVEL%==0 (
    echo Please run as Administrator or run with Defendpoint.
    goto :EOF
)

rem Associate the file type with the command.
ftype %FILE_TYPE%=%COMMAND%

rem Add EXTENSION to PATHEXT for this session and permanently.
rem
call :TO_UPPER %EXTENSION%
echo %PATHEXT% | findstr /i %TO_UPPER_RESULT% > NUL:
if not %ERRORLEVEL%==0 (
    rem The extension is not in PATHEXT, so add it for this session.
    set PATHEXT=%PATHEXT%;%TO_UPPER_RESULT%
)
rem Update PATHEXT permanently.
setx PATHEXT %PATHEXT%

rem Cleanup
set EXTENSION=
set FILE_TYPE=
set COMMAND=
set TO_UPPER_RESULT=
exit /b


:TO_UPPER
set TO_UPPER_RESULT=%*
set TO_UPPER_RESULT=%TO_UPPER_RESULT:a=A%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:b=B%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:c=C%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:d=D%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:e=E%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:f=F%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:g=G%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:h=H%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:i=I%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:j=J%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:k=K%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:l=L%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:m=M%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:n=N%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:o=O%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:p=P%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:q=Q%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:r=R%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:s=S%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:t=T%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:u=U%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:v=V%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:w=W%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:x=X%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:y=Y%
set TO_UPPER_RESULT=%TO_UPPER_RESULT:z=Z%
exit /b

