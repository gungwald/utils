// Lists the date/time properties of a file.

var fs = new ActiveXObject("Scripting.FileSystemObject");
var shell = new ActiveXObject("WScript.Shell");

// Restart with cscript if we're running wscript.
if (WScript.FullName.search(/WScript/i) >= 0)
{
    shell.Run("%comspec% /k cscript /nologo \"" + WScript.ScriptFullName + "\"");
    WScript.Quit(0);
}

if (WScript.Arguments.length > 0)
{
    for (var i = 0; i < WScript.Arguments.length; i++)
    {
        var file = fs.GetFile(WScript.Arguments(i));

        WScript.Echo(file.Path);
        WScript.Echo("    Created:       " + file.DateCreated);
        WScript.Echo("    Last Accessed: " + file.DateLastAccessed);
        WScript.Echo("    Last Modified: " + file.DateLastModified);
    }
}
else
{
    WScript.Echo("Please provide a file name on the command line.");
}


