@echo off

rem Script:      groups.bat
rem
rem Description: This is a batch file which lists the current 
rem              user's Active Directory groups, just like the UNIX "groups" 
rem              command.
rem
rem              This is the only way to make this work inside one file,
rem              which can be typed with a single word command, and
rem              writes output to standard output on the console. This is
rem              because the default script engine is wscript which does
rem              not allow writing to the standard output (console). The
rem              JavaScript file must be invoked with cscript instead of
rem              wscript to be able to write to standard output.
rem
rem Author:      Bill Chatfield <bill_chatfield@yahoo.com>

setlocal
set TEMP_GROUPS_SCRIPT=%TEMP%\%~nx0-%TIME::=.%-%RANDOM%.js


rem Right parentheses must be quoted with ^
rem The less than sign (<) must be quoted with ^

(
    @echo.// Get the current user.
    @echo.var activeDirectory = new ActiveXObject("ADSystemInfo"^);
    @echo.var userName = activeDirectory.UserName;
    @echo.var userUrl = "LDAP://" + userName;
    @echo.var user = GetObject(userUrl^);
    @echo.
    @echo.// Find all the groups for this user.
    @echo.var groups = user.GetEx("memberOf"^).toArray(^);
    @echo.var group;
    @echo.for (var i = 0; i ^< groups.length; i++^) {
    @echo.    group = groups[i].split(/,/^)[0].split(/=/^)[1];
    @echo.    WScript.StdOut.WriteLine(group^);
    @echo.}
) > "%TEMP_GROUPS_SCRIPT%"

cscript //nologo "%TEMP_GROUPS_SCRIPT%"
del "%TEMP_GROUPS_SCRIPT%"
endlocal

