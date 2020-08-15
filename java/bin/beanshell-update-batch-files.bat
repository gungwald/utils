@echo off
setlocal
set TEMPLATE=beanshell-template.bat
for %%b in (findclass.bat create-gradle-project.bat) do (
    echo Copying %TEMPLATE% to %%b.
    copy %TEMPLATE% %%b
)
