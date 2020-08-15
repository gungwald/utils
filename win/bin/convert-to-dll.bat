@echo off
pexports -v -o c:\windows\system32\wtsapi32.dll > wtsapi32.def
rem or use gendef
rem dlltook -k
