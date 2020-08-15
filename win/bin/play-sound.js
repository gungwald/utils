// Calls the Win32 PlaySound function via a dynamically generated PowerShell
// program which uses embedded C# code to link to Win32 via pinvoke.

/**
 * C NULL pointer value.
 */
var NULL = 0;

var SND_SYNC        =      0x0000; /* play synchronously (default) */
var SND_ASYNC       =      0x0001; /* play asynchronously */
var SND_NODEFAULT   =      0x0002; /* silence (!default) if sound not found */
var SND_MEMORY      =      0x0004; /* pszSound points to a memory file */
var SND_LOOP        =      0x0008; /* loop the sound until next sndPlaySound */
var SND_NOSTOP      =      0x0010; /* don't stop any currently playing sound */
var SND_NOWAIT      =  0x00002000; /* don't wait if the driver is busy */
var SND_ALIAS       =  0x00010000; /* name is a registry alias */
var SND_ALIAS_ID    =  0x00110000; /* alias is a predefined ID */
var SND_FILENAME    =  0x00020000; /* name is file name */
var SND_RESOURCE    =  0x00040004; /* name is resource name or atom */
var SND_PURGE       =      0x0040; /* purge non-static events for task */
var SND_APPLICATION =      0x0080; /* look for application specific association */
var SND_SENTRY      =  0x00080000; /* Generate a SoundSentry event with this sound */
var SND_RING        =  0x00100000; /* Treat this as a "ring" from a communications app - don't duck me */
var SND_SYSTEM      =  0x00200000; /* Treat this as a system sound */

/**
 * Plays a sound via the Win32 fuction:
 *
 * BOOL PlaySound(
 *     LPCTSTR pszSound,
 *     HMODULE hmod,
 *     DWORD   fdwSound);
 */
function PlaySound(sound, moduleHandle, flags) {
    var shell = new ActiveXObject("WScript.Shell");
    var lines = '';

    if (moduleHandle == null) {
        moduleHandle = 0;
    }

    if (flags == null) {
        flags = SND_FILENAME | SND_NODEFAULT;
    }

    // Setup powershell.exe to receive code on stdin.
    var psCommand = "powershell -noprofile -executionpolicy bypass -command -";
    var psProcess = shell.Exec(psCommand);
    var psCode = psProcess.StdIn;
    // Write PowerShell code directly to the powershell.exe process.
    // Multi-line statements don't work when sending the code via
    // stdin to PowerShell. Each statement has to be on one line.
    psCode.WriteLine("$sound = '" + sound + "'");
    psCode.WriteLine("$moduleHandle = new-object System.UIntPtr " + moduleHandle);
    psCode.WriteLine("$flags = " + flags);
    // A multi-line here doc will cause the PowerShell process to exit without any error. Yea...
    psCode.WriteLine("$win32Func = '[DllImport(\"winmm.dll\", CharSet = CharSet.Unicode, SetLastError = true)] public static extern bool PlaySound(string sound, UIntPtr moduleHandle, uint flags);'");
    psCode.WriteLine("$dll = add-type -memberdefinition $win32Func -name 'winmm' -namespace 'Win32' -passthru");
    psCode.WriteLine("$result = $dll::PlaySound($sound, $moduleHandle, $flags)");
    psCode.WriteLine('if ($result) {$exitCode = 0} else {$exitCode = 1}');
    psCode.WriteLine('[Environment]::Exit($exitCode)');
    // PlaySound doesn't set the error code so there's no reason to do this:
    // psCode.WriteLine('if (! $playSoundResult) { $code = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error(); $ex = new-object System.ComponentModel.Win32Exception $code; echo $ex.Message }');
    psCode.Close(); // Required, or the StdOut operations cause a hang.

    // Collect all stdout lines and display them.
    while (! psProcess.StdOut.AtEndOfStream) {
        lines += psProcess.StdOut.ReadLine() + "\r\n";
    }
    if (lines.length > 0) {
        WScript.Echo(lines);
    }
    // Collect all stderr output and display it.
    lines = '';
    while (! psProcess.StdErr.AtEndOfStream) {
        lines += psProcess.StdErr.ReadLine() + "\r\n";
    }
    if (lines.length > 0) {
        WScript.Echo(lines);
    }
    // Wait for the process to exit.
    while (psProcess.Status == 0) {
        WScript.Sleep(100);
    }
    return psProcess.ExitCode == 0 ? true : false;
}

// Call Win32 PlaySound function.
var result = PlaySound("C:\\Users\\bill.chatfield\\Music\\snd.wav", NULL, SND_FILENAME);

// Use the result of the PlaySound function as our exit code.
WScript.Quit(result ? 0 : 1);

