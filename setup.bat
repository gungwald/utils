@for /d %%s in (%~dp0*.*) do if exist %%s\setup.bat %%s\setup.bat
