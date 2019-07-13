@echo off

rem //////////////////////////////////////////////////////////////////////////
rem
rem Knowledge taken from: 
rem superuser.com/questions/139899/see-available-drives-from-windows-cli
rem
rem Windows will order the columns, so we have no control over the order 
rem that they appear. I've specified them on the command line in the
rem same order that Windows enforces in the output, so there is no
rem confusion.
rem
rem Other useful columns:
rem   ProviderName - This is too long to fit in 80 columns
rem
rem Other commands:
rem   net use - show the connected network drives
rem

echo.

wmic logicaldisk get Caption,Description,FileSystem,Size,VolumeName
