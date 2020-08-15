@echo off

setlocal

rem
rem     Check the command line arguments.
rem

if not exist "%1" (
    echo %0: Argument 1 is an invalid file name or is empty: %1
    goto end
)
if not exist "%2" (
    echo %0: Argument 2 is an invalid file name or is empty: %2
    goto end
)

rem
rem     Find a unique number to differentiate this instance of DiffJar.bat
rem     from any others that may be running at the same time.  This is for
rem     the purpose of creating uniquely named temporary files.  It also
rem     establishes that number for use only in this instance by creating
rem     a lock file using the number, which other instances will look for
rem     to avoid using the same number.  There is only a very small
rem     possibility of a timing issue where two instances check at the
rem     same time, don't find a lock file and both then try to create same
rem     one.  In that case we loop and try again.
rem

set unique=null
set i=0
:beginloop
    if %i%==100 goto endloop
    set lockFile=%TEMP%\%~n0%i%.lock
    if not exist %lockFile% (
        echo Locked by %0 > %lockFile%
        if errorlevel 1 (
            echo %0: encountered an error, but will retry
            set /a i=%i% + 1
            goto beginloop
        )
        set unique=%i%
        goto endloop
    )
    set /a i=%i% + 1
goto beginloop
:endloop

if %unique%==null (
    echo %0: cannot find unique number for temporary files
    goto end
)

rem
rem     Set up names of the required temporary files, using the unique
rem     number, %unique%, determined above.
rem

set toc1=%TEMP%\%~n0%unique%.%~n1%~x1.toc
set toc2=%TEMP%\%~n0%unique%.%~n2%~x2.toc
set fileList1=%TEMP%\%~n0%unique%.%~n1%~x1.filelist
set fileList2=%TEMP%\%~n0%unique%.%~n2%~x2.filelist
set sortedFileList1=%TEMP%\%~n0%unique%.%~n1%~x1
set sortedFileList2=%TEMP%\%~n0%unique%.%~n2%~x2

rem
rem     Get the table of contents for the first jar file and then
rem     extract only the file name column, which is column 8,
rem     ignoring the date, time and other columns.
rem

jar -tvf %1 > %toc1%
if errorlevel 1 goto end
for /f "tokens=8" %%i in (%toc1%) do (
    echo %%i >> %fileList1%
)
sort %fileList1% /o %sortedFileList1%

rem
rem     Get the table of contents for the second jar file and then
rem     extract only the file name column, which is column 8,
rem     ignoring the date, time and other columns.
rem

jar -tvf %2 > %toc2%
if errorlevel 1 goto end
for /f "tokens=8" %%i in (%toc2%) do (
    echo %%i >> %fileList2%
)
sort %fileList2% /o %sortedFileList2%

rem
rem     Perform the comparison of the list of files in each jar.
rem

fc %sortedFileList1% %sortedFileList2%

rem
rem     This program's only point of termination.  It cleans up
rem     temporary files and variables.
rem

:end
if defined lockFile if exist %lockFile% del %lockFile%
if defined toc1 if exist %toc1% del %toc1%
if defined toc2 if exist %toc2% del %toc2%
if defined fileList1 if exist %fileList1% del %fileList1%
if defined fileList2 if exist %fileList2% del %fileList2%
if defined sortedFileList1 if exist %sortedFileList1% del %sortedFileList1%
if defined sortedFileList2 if exist %sortedFileList2% del %sortedFileList2%
endlocal
