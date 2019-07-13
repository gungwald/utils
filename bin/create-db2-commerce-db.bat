setlocal

rem
rem Change these if necessary.
rem

set wctkdir=C:\opt\WCToolkitEE60
set dbtype=db2
set dbhome=C:\opt\IBM\SQLLIB
set db=COMMERCE
set adm=db2admin
set admpw=FGsltwtHgH0bs
set usr=%adm%
set usrpw=%admpw%

pushd %wctkdir%\bin

call setdbtype %dbtype% %dbhome% %db% %adm% %admpw% %usr% %usrpw% createdb

call updatedb %dbtype% %db% %usr% %usrpw%

popd

endlocal

pause

