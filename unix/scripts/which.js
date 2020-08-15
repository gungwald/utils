// Implement UNIX which
// Bill Chatfield
// July 19, 2004

var shell = WScript.CreateObject("WScript.Shell");
var args = WScript.Arguments;
var name = args(0);

// Duh
var out = WScript.StdOut;
var err = WScript.StdErr;

// Arguments

// Get PATH and PATHEXT values
var env = shell.Environment("Process");
var pathExt = env("PATHEXT");
var extensions = pathExt.split(';');
var path = env("PATH");
var directories = path.split(';');

var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
var i, j;
var suspectName;
var suspectFile;

for (i in directories) {
    for (j in extensions) {
        suspectName = directories[i] + '\\' + name + extensions[j];
        if (fileSystem.FileExists(suspectName)) {
            suspectFile = fileSystem.GetFile(suspectName);
            WScript.Echo(suspectFile.Path);
        }
    }
}

