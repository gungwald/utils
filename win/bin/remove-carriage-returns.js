/*  remove-carriage-returns.js 
        
        - Removes any carriage returns not part of a line terminator
        - Runs out-of-the-box on Windows requiring no dependencies
        - Usage: remove-carriage-returns input-file output-file
  
    Author: Bill Chatfield

    Documentation for Windows Script Host features used herein:
 
    CreateTextFile   https://msdn.microsoft.com/en-us/library/5t9b5c0c%28v=vs.84%29.aspx
    FileSystemObject https://msdn.microsoft.com/en-us/library/2z9ffy99%28v=vs.84%29.aspx
    GetTempName      https://msdn.microsoft.com/en-us/library/w0azsy9b%28v=vs.84%29.aspx
    OpenTextFile     https://msdn.microsoft.com/en-us/library/314cz14s%28v=vs.84%29.aspx
    
    Status: Working, but even though the PowerShell WindowStyle is set to
            Hidden, the window still flashes up before it disappears. There
            seems to be no way to fix this.
*/

// This is like an import or include statement.
var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
var shell = new ActiveXObject("WScript.Shell");

// Constants
var ForReading = 1;
var ForWriting = 2;
var ForAppending = 8;

function removeCarriageReturnsFromStream(input, output) {
    var c = '';
    var previousChar = '';

    while (! input.AtEndOfStream) {
        var c = input.Read(1);
        // *******************************************************************
        // 
        // This is the place where the goal is accomplished. Everything else is
        // just setup work.
        //
        // *******************************************************************
        if (c == '\n') {
            output.Write(previousChar);
            output.Write(c);
        }
        else if (c != '\r') {
            output.Write(c);
        }
        previousChar = c;
    }
}

function openStreamIfNeeded(unidentifiedFileThing, ioMode) {
    var stream;
    // The instanceof operator does not work properly for String literals
    // defined without the 'new String()' constructor. It also can't determine
    // the true type of an automation object as it sees it only as an Object.
    // So the typeof functtion has to be used instead.
    if (typeof(unidentifiedFileThing) == 'string') {
        if (ioMode == ForReading) {
            // Assume 'thing' is a file name and open the file.
            // TextStream is the type returned by OpenTextFile and 
            // CreateTextFile.
            stream = fileSystem.OpenTextFile(unidentifiedFileThing, ioMode);
        }
        else if (ioMode == ForWriting) {
            // Assume 'thing' is a file name and open the file.
            // TextStream is the type returned by CreateTextFile, which will
            // be assigned to input variable.
            stream = fileSystem.CreateTextFile(unidentifiedFileThing);
        }
    }
    else {
        // Otherwise assume it is an already open stream. It would be nice
        // to be able to test for a TextStream, but that is impossible, due
        // to this technology being created by Microsoft.
        stream = unidentifiedFileThing;
    }
    return stream;
}

function closeIfNeeded(originalThing, stream) {
    // Close only the stream that it was necessary to open. This should avoid
    // closing stdin and stdout.
    if (typeof(originalThing) == 'string') {
        stream.Close();
    }
}

/**
 * Removes any errant carriage returns in the file that are not part
 * of a line termination sequence: \r\n
 *
 * @param {String} input    The name of the input file or and open TextStream
 *                          containing carriage returns to be removed 
 * @param {String} output   Where to write the resulting file with 
 *                          carriage returns removed, either the name of an
 *                          output file or an already open TextStream for
 *                          output
 */
function removeCarriageReturns(input, output) {
    var inputStream = openStreamIfNeeded(input, ForReading);
    var outputStream = openStreamIfNeeded(output, ForWriting);
    removeCarriageReturnsFromStream(inputStream, outputStream);
    closeIfNeeded(output, outputStream);
    closeIfNeeded(input, inputStream);
}

function usage() {
    var usage = "Usage:\n\n\t" + WScript.ScriptName + " input-file output-file";
    usage += "\n\nTo use I/O redirection, invoke the script with CScript.exe:\n\n\tcscript " + WScript.ScriptName + " < input-file > output-file";
    usage += "\n\n\ttype file | cscript " + WScript.ScriptName + " | find \"Daenerys Targaryen\"";
    WScript.Echo(usage);
}

function isScriptEngineWScript() {
    var scriptEngine = WScript.FullName;
    scriptEngine = scriptEngine.toLowerCase()
    return scriptEngine.match(/wscript.exe$/) != null;
}

function isScriptEngineCScript() {
    var scriptEngine = WScript.FullName;
    scriptEngine = scriptEngine.toLowerCase()
    return scriptEngine.match(/cscript.exe$/) != null;
}

function isHelpSwitch(arg) {
    sw = arg.toLowerCase();
    return sw=='--help' || sw=='-help' || sw=='-h' || sw=='-?'
        || sw=='/help' || sw=='/h' || sw=='/?';
}

/**
 * Runs an arbitrary PowerShell script.
 *
 * @param {String} code     Lines of the PowerShell script
 */
function runPowerShellCode(code) {
    // Setup powershell.exe to receive code on stdin.
    var psCommand = "powershell -noprofile -executionpolicy bypass -windowstyle hidden -command -";
    var psProcess = shell.Exec(psCommand);
    var codeStream = psProcess.StdIn;
    var outputLines = new Array();
    var errorLines = new Array();

    // Write PowerShell code directly to the powershell.exe process.
    // Multi-line statements don't work when sending the code via
    // stdin to PowerShell. Each statement has to be on one line.
    codeStream.Write(code);
    // Required, or the StdOut operations cause a hang.
    codeStream.Close(); 

    // Collect all output.
    while (! psProcess.StdOut.AtEndOfStream) {
        outputLines.push(psProcess.StdOut.ReadLine());
    }

    // Collect all stderr output.
    while (! psProcess.StdErr.AtEndOfStream) {
        errorLines.push(psProcess.StdErr.ReadLine());
    }
    //
    // Wait for the process to exit.
    while (psProcess.Status == 0) {
        WScript.Sleep(100);
    }
    return { stdout:outputLines, stderr:errorLines, exitCode:psProcess.ExitCode };
}


function buildFileDialogCode(ioMode) {
    var dialog;
    var multiselect;
    var desc;
    if (ioMode == ForReading) {
        dialog = 'System.Windows.Forms.OpenFileDialog';
        multiselect = true;
        desc = 'input';
    }
    else {
        dialog = 'System.Windows.Forms.SaveFileDialog';
        multiselect = false;
        desc = 'output';
    }

    var code = '[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null\r\r';
    // The $form is necessary or the dialog will show up behind everything. Duh...
    code += '$form = new-object System.Windows.Forms.Form\r\n';
    code += '$form.topMost = $true\r\n';
    code += '$fileDialog = new-object ' + dialog + '\r\n';
    // '$fileDialog.filter = "All files|*.*"'
    // '$fileDialog.multiselect = $' + multiselect
    code += '$fileDialog.title = "Choose an ' + desc + ' file"\r\n';
    // Work-around for missing window. It is unknonwn why this fixes the problem.
    code += '$fileDialog.showHelp = $true\r\n';
    // If the user clicks OK, it returns true. If the user clicks Cancel it returns false.
    // This needs to be all on one line or it doesn't work.
    code += 'if ($fileDialog.showDialog($form)) {$fileDialog.fileNames | foreach-object -process {write-output $_} }\r\n';
    code += '$form.close()\r\n';
    // [System.Windows.Forms.Application]::Exit($null)
    // [Environment]::exit(0)
    return code;
}

function chooseFile(ioMode) {
    var results = runPowerShellCode(buildFileDialogCode(ioMode));
    if (results.exitCode == 0) {
        return results.stdout[0];
    }
    else {
        WScript.Echo(results.stderr[0]);
    }
}

// *******************************************************************
// 
// Main Program
//
// *******************************************************************
var args = WScript.Arguments;
if (args.length == 0) {
    if (isScriptEngineWScript()) {
        var input = chooseFile(ForReading);
        var output = chooseFile(ForWriting);
        removeCarriageReturns(input, output);
        WScript.Echo("Read " + input + " and wrote " + output);
    }
    else if (isScriptEngineCScript()) {
        removeCarriageReturns(WScript.StdIn, WScript.StdOut);
    }
    else {
        WScript.Echo("Unknown script engine: " + WScript.FullName);
    }
}
else if (args.length == 1) {
    if (isHelpSwitch(args.Item(0))) {
        usage();
    }
    else if (isScriptEngineWScript()) {
        var output = chooseFile(ForWriting);
        removeCarriageReturns(args.Item(0), output);
        WScript.Echo("Read " + args.Item(0) + " and wrote " + output);
    }
    else if (isScriptEngingCScript()) {
        removeCarriageReturns(args.Item(0), WScript.StdOut);
    }
    else {
        WScript.Echo("Unknown script engine: " + WScript.FullName);
    }
}
else if (args.length == 2) {
    removeCarriageReturns(args.Item(0), args.Item(1));
}
else {
    WScript.Echo("Too many arguments: " + args);
    usage();
}

