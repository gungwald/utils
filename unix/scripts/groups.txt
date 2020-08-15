// Script:      groups.js
//
// Description: This is a Windows Script Host script which lists the current 
//              user's Active Directory groups, just like the UNIX "groups" 
//              command.
//
// Author:      Bill Chatfield <bill_chatfield@yahoo.com>
//
// Invocation:
//
// This script is designed to make its output visible to the user regardless
// of how it was invoked. These are the invocation options:
//
// 1. Double-click it from the desktop. It will pop up a Command Prompt window
//    to display output in. The window will not disappear when the command
//    completes. It will remain until you close it manually.
//
// 2. Type its name in a Command Prompt. As long as the file has the ".js"
//    extension, this will work regardless of whether the user types the
//    extension or not. This is because the ".js" extension is listed in the
//    PATHEXT environment variable by default in Windows. 
//
//    It will also pop up a new Command
//    Prompt window in this case. The default script engine is WScript
//    which insists on opening a new window for everything. There's no
//    reasonable way to fix this. Remember, this is Windows.
//
// 3. In an existing Command Prompt window, type "cscript groups.js". This is
//    the only way to get output to appear in an existing Command Prompt
//    window.
//
// 4. This is the recommended method if you want it to work like the UNIX
//    "groups" command, meaning that you can invoke it by typing "groups"
//    in a Command Prompt and it will display its output in that same
//    Command Prompt window.
//
//    Put this file in a directory in your PATH. Create a 
//    groups.bat file in the same directory and containing this line:
//
//        @cscript //nologo "%~dp0%~n0.js"
//        
//    The %~dp0 mess specifies the drive and path to the groups.bat file
//    and the groups.js file, since you put then in the same directory.
//    The %~n0 mess specifies the name of the groups.bat file, without the
//    ".bat" extension. Then the ".js" extension is added to the end so
//    that the full path name to this groups.js file is specified as the
//    target script. The quotes are needed in case there are any spaces in
//    the path or the file name.

// Restart with cscript if we're running wscript so that we can write to 
// stdout rather than displaying a separate popup for each group name.
if (WScript.FullName.search(/WScript/i) >= 0) {
    var shell = new ActiveXObject("WScript.Shell");
    var cmd = "%comspec% /c start \"" + WScript.ScriptName + "\" %comspec% /k cscript /nologo \"" + WScript.ScriptFullName + "\" ^| sort ^| more";
    var exitCode = shell.Run(cmd, 0, true);
    WScript.Quit(exitCode);
}

// Get the current user.
var activeDirectory = new ActiveXObject("ADSystemInfo");
var userName = activeDirectory.UserName;
var userUrl = "LDAP://" + userName;
var user = GetObject(userUrl);

// Find all the groups for this user.
var groups = user.GetEx("memberOf").toArray();
var group;
for (var i = 0; i < groups.length; i++) {
    group = groups[i].split(/,/)[0].split(/=/)[1];
    WScript.StdOut.WriteLine(group);
}

