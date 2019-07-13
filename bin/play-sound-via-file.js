// Calls the Win32 PlaySound function via a dynamically generated PowerShell
// program which uses embedded C# code to link to Win32 via pinvoke.
//
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
 *  LPCTSTR pszSound,
 *  HMODULE hmod,
 *  DWORD   fdwSound);
 */
function PlaySoundViaFile(sound, moduleHandle, flags) {
    var EXEC_PROC_RUNNING = 0;
    var FOR_WRITING = 2;
    var fs = new ActiveXObject("Scripting.FileSystemObject");
    var psScript = "PlaySound.ps1";
    var out = fs.OpenTextFile(psScript, FOR_WRITING , true);

    // Write PowerShell code to temp file, then run it.
    out.WriteLine("param (");
    out.WriteLine('    [string]$sound = $(throw "-sound is required."),');
    out.WriteLine('    [string]$modulehandle = 0,');
    out.WriteLine('    [string]$flags = ' + SND_FILENAME);
    out.WriteLine(")");
    out.WriteLine("$win32PlaySoundFunc = @'");
    out.WriteLine("[DllImport(\"winmm.dll\", CharSet = CharSet.Unicode, SetLastError = true)]");
    out.WriteLine("public static extern bool PlaySound(string sound, UIntPtr moduleHandle, uint flags);");
    out.WriteLine("'@");
    out.WriteLine("$winmmdll = Add-Type -MemberDefinition $win32PlaySoundFunc -Name 'winmm' -Namespace 'Win32' -PassThru");
    out.WriteLine("$result = $winmmdll::PlaySound($sound, $moduleHandle, $flags)");
    out.WriteLine("if ($result -eq $False) {");
    out.WriteLine("    # Display the Win32 error.");
    out.WriteLine("    throw ( New-Object ComponentModel.Win32Exception )");
    out.WriteLine("}");
    out.Close();

    var psCommand = "powershell -noprofile -executionpolicy bypass -file " + psScript + ' "' + sound + '" ' + moduleHandle + " " + flags;
    var shell = new ActiveXObject("WScript.Shell");
    var psProcess = shell.Exec(psCommand);
    psProcess.StdIn.Close();    // Required or the StdOut operations cause a hang.
    while (! psProcess.StdOut.AtEndOfStream) {
        WScript.Echo(psProcess.StdOut.ReadLine());
    }
    while (! psProcess.StdErr.AtEndOfStream) {
        WScript.Echo(psProcess.StdErr.ReadLine());
    }
}

var result = PlaySoundViaFile("C:\\Users\\bill.chatfield\\Music\\snd.wav", NULL, SND_FILENAME);

WScript.Quit(result ? 0 : 1);

