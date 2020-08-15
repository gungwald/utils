@echo off
setlocal
for /f "skip=1 tokens=3" %%r in ('reg query HKLM\SOFTWARE\Cygwin\setup /v rootdir') do set CYGWIN_ROOT=%%r
%CYGWIN_ROOT%\bin\bash --login -c /usr/local/bin/lock %*
endlocal
