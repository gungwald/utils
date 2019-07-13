rem
rem This does not work for some reason...
rem
rem Rotate wallpaper images from those found in the user's
rem Pictures folder.
rem

set WINXP_PIC_DIR=%USERPROFILE%\My Documents\My Pictures
set WIN7_PIC_DIR=%USERPROFILE%\Pictures

if exist "%WIN7_PIC_DIR%" (
    set PIC_DIR=%WIN7_PIC_DIR%
) else (
    set PIC_DIR=%WINXP_PIC_DIR%
)

for /r "%PIC_DIR%" %%p in (*.jpg *.gif *.png) do (
    reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%%p" /f
    sleep 300
)
