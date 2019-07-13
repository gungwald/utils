// Lists the date/time properties of a file.

var fs = new ActiveXObject("Scripting.FileSystemObject");
var shell = new ActiveXObject("WScript.Shell");
var args = WScript.Arguments;

if (args.length > 0)
{
    for (var i = 0; i < args.length; i++)
    {
        var file = fs.GetFile(args(i));

        WScript.Echo("");
        WScript.Echo(file.Name);
        WScript.Echo("    Created:       " + file.DateCreated);
        WScript.Echo("    Last Accessed: " + file.DateLastAccessed);
        WScript.Echo("    Last Modified: " + file.DateLastModified);
    }
}
else
{
    WScript.Echo("Please provide a file name on the command line.");
}


