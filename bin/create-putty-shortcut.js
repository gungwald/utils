var shell = WScript.CreateObject("WScript.Shell");
var desktop = shell.SpecialFolders("Desktop");
var link = shell.CreateShortcut(desktop + "\\Putty.lnk");
link.TargetPath = "C:\\Program Files (x86)\\Putty\\putty.exe";
link.WindowStyle = 1;
link.IconLocation = "C:\\Program Files (x86)\\Putty\\putty.exe, 0";
link.Description = "Run Putty";
link.WorkingDirectory = desktop;
link.Save();

