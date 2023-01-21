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
// This script is designed to be double-clicked from Windows Explorer.
// It will pop up a Command Prompt which will contain the output. This
// is done so that the output can be copy and pasted, unlike the output
// that appears in a WScript.Echo window. This is the primary use-case
// for most Windows users.

// Restart with cscript if we're running wscript so that we can write to 
// stdout rather than displaying a separate popup for each group name.
if (WScript.FullName.search(/WScript/i) >= 0) {
    var shell = new ActiveXObject("WScript.Shell");
    var cmd = "cscript //nologo \"" + WScript.ScriptFullName + "\"";
    var exitCode = shell.Run(cmd, 1, true);
    WScript.Quit(exitCode);
}

// Get the current user.
var adSystemInfo = new ActiveXObject("ADSystemInfo");
var userDistinguishedName = adSystemInfo.UserName;
var userDnUrl = "LDAP://" + userDistinguishedName;
var adUser = GetObject(userDnUrl);

WScript.StdOut.WriteLine("Active Directory groups for " + userDistinguishedName + ":");
WScript.StdOut.WriteLine();

// Find all the groups for this user.
var groups = adUser.GetEx("memberOf").toArray();
var group;
for (var i = 0; i < groups.length; i++) {
    group = groups[i].split(/,/)[0].split(/=/)[1];
    WScript.StdOut.WriteLine(group);
}
WScript.StdOut.WriteLine();
WScript.StdOut.Write("Press [Enter] to close: ");
var line = WScript.StdIn.ReadLine();
