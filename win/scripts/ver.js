// Run with: cscript //nologo ver.js
//
function writeln() {
    try {
        for (var i = 0; i < arguments.length; i++) {
            WScript.StdOut.Write(arguments[i]);
        }
        WScript.StdOut.WriteLine();
    }
    catch (e) {
        WScript.Echo("This needs to be run as follows: cscript //nologo ver.js");
        WScript.Quit(1);
    }
}

var systems = GetObject("winmgmts:").InstancesOf("Win32_OperatingSystem");
for (var i = 0; i < systems.Count; i++) {
    var system = systems.ItemIndex(i);
    var propEnum = new Enumerator(system.Properties_);
    while (!propEnum.atEnd()) {
        var prop = propEnum.item();
        writeln(prop.Name + "=" + prop.Value);
        propEnum.moveNext();
    }
}
