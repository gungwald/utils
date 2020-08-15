// Script to Start Sql.class
// This is a Windows Script Host JScript script

// Settable parameters
var jvm = "jview";
var as400toolkit = "C:\\projects\\venus\\dist\\lib\\jt400.zip";
var sqlClassDirectory = "D:\\opt\\classes";

// Everything beyond this point should not change.
var classpathSwitch;
var classpath = as400toolkit + ";" + sqlClassDirectory;

if (jvm == "jview")
    classpathSwitch = "/p /cp:a";
else
    classpathSwitch = "-cp";  // jdk1.1.x needs -cp not -classpath

var args = WScript.arguments;
var cmdFileName;
var outFileName;

if (args.length > 2 || args.length == 0)
{
    usage();
    WScript.Quit(1);
}
else
{
    cmdFileName = args(0);
    if (args.length == 1)
    {
        outFileName = cmdFileName + ".result.html";
    }
    else
    {
        outFileName = args(1);
    }
}

// Quote them both.  Otherwise file name with spaces will fail.
cmdFileName = "\"" + cmdFileName + "\"";
outFileName = "\"" + outFileName + "\"";

var WshShell = WScript.CreateObject("WScript.Shell");

// Cannot combine variable definition and string concatenation on the same line!
var cmd;
cmd = jvm + " " + classpathSwitch + " " + classpath + " Sql " + cmdFileName + " " + outFileName;

var exitCode = WshShell.Run(cmd, 1, true);
exitCode = WshShell.Run(outFileName);


// Functions...
function usage()
{
    WScript.Echo("usage: sql sqlCmdFileName [outputFileName]");
}

