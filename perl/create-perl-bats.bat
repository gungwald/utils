@for %%S in (%~dp..\scripts\*.pl) do echo "@perl %~dp0..\scripts\%~n0.pl %*" > %%~dpS%%~nS.bat
