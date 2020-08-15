@echo off
setlocal
set PATH=%PATH%;C:\Program Files (x86)\Git\bin
rem
rem Beware of spaces in the URL represented as %20 because cmd.exe will
rem strip out the '%' and break the URL. Change any %20 sequence to an
rem actual space and surround with quotes. Quotes won't protect the '%'.
rem
curl -o PRODOS-4.0.2.dsk "ftp://ftp.apple.asimov.net/pub/apple_II/images/masters/prodos/PRODOS-8 v4.0.2 System.dsk"
endlocal
