@echo off

setlocal
pushd %USERPROFILE%\git

for /d %%d in (*) do (
    pushd %%d
    git pull origin master
    popd
)

popd
endlocal
