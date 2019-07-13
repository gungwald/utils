@echo off

rem **********************************************************************
rem
rem Generates a sortable timestamp suitable for use as part of a file 
rem name. The output or return value is put into the TIMESTAMP
rem environment variable so that another batch file can use it.
rem
rem Bill.Chatfield
rem 2008-11-20
rem
rem **********************************************************************

rem
rem Get the current date and time once.
rem
set CDATE=%DATE%
set CTIME=%TIME%

rem
rem Change all colons to periods so that the
rem result can be used in a file name.
rem
set CTIME=%CTIME::=.%

rem
rem Prepend a 0 if it is missing so that the result will sort
rem correctly.
rem
if "%CTIME:~0,1%"==" " set CTIME=0%CTIME:~1,10%

rem
rem Extract the year, month and day so that they can be
rem properly arranged.
rem
set CYEAR=%CDATE:~10,4%
set CMONTH=%CDATE:~4,2%
set CDAY=%CDATE:~7,2%

rem The following TIMESTAMP assignment is the return value.

set TIMESTAMP=%CYEAR%.%CMONTH%.%CDAY%-%CTIME%

rem
rem Clean up
rem
set CDATE=
set CTIME=
set CYEAR=
set CMONTH=
set CDAY=
