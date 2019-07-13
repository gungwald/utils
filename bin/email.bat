@cscript //nologo "%~dp0..\scripts\%~n0.js"
@goto :EOF

rem Runs a JScript file in the "scripts" directory. The JScript file must
rem have the same name as this file, but with the "js" extension. The
rem "scripts" directory must have the same parent as the directory this
rem file is in.
rem
rem    %~dp0   specifies the drive and path of this script, argument 0.
rem    %~dp0.. specifies the parent directory.
rem    %~n0    specifies the name of this file, without the extension.
