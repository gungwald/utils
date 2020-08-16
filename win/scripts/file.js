var i;
var fileSystem;
var f;
var fileName;

fileSystem = WScript.CreateObject("Scripting.FileSystemObject");

for (i = 0; i < WScript.Arguments.length; i++) {
    fileName = WScript.Arguments(i);
    if (fileSystem.FileExists(fileName)) {
        f = fileSystem.GetFile(fileName);
        WScript.Echo(f.Name + ": " + f.Type);
    }
    else if (fileSystem.FolderExists(fileName)) {
        WScript.Echo(fileName + ": Folder/Directory");
    }
    else {
        WScript.Echo("File does not exist: " + fileName);
    }
}
