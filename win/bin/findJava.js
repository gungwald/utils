// This is unfinished. Use findjava.bat which is inherently more
// efficient because it uses build-in Windows commands to search
// the file system for a signature that is always present in
// a Java installation. Also because it can search the whole
// file system, it will find Java installations that do not
// appear in the registry or in the PATH.
//
var g_shell = new ActiveXObject("WScript.Shell");
var g_fs = new ActiveXObject("Scripting.FileSystemObject");
var g_env = g_shell.Environment("SYSTEM");

// Create an object type AppException
function AppException(message) {
    this.message=message;
    this.name="AppException";
    
    // Make the exception convert to a pretty string when used as a 
    // string (e.g. by the error console)
    this.prototype.toString = function() {
        return this.name + ': "' + this.message + '"';
    }
}

/**
 * Looks in standard registry location to find Java.
 *
 * On 64-bit Windows, when RegRead is called from a 32-bit programs like Vim,
 * HKLM\Software\JavaSoft is replaced by HKLM\SOFTWARE\Wow6432Node\JavaSoft
 *
 * @param   {number} minimumVersion An official version number: 1.5, 1.6, 1.7
 * @return  {File}                  Object representing java.exe of the 
 *                                  requested version
 */
function findJavaViaRegistry(minimumVersion) {
    var java = null;
    var jreKey = "HKLM\\Software\\JavaSoft\\Java Runtime Environment";
    var currentVersionValue = jreKey + "\\CurrentVersion";
    var currentVersion = g_shell.RegRead(currentVersionValue); // Throws Error if key/value not found
    if (currentVersion >= minimumVersion) {
        var javaHome = g_shell.RegRead(jreKey + "\\" + currentVersion + "\\JavaHome"); // Throws Error if key/value not found
        var javaExeName = javaHome + "\\bin\\java.exe";
        if (g_fs.FileExists(javaExeName)) {
            java = g_fs.GetFile(javaExeName);
        }
        else {
            throw new AppException("Java binary specified in registry does not exist: " + javaExeName);
        }
    }
    else {
        throw new AppException("Available Java version " + currentVersion + " does not meet the minimum requirement " + minimumVersion);
    }
    return java;
}

function findJavaViaPath(minimumVersion) {
    var path = 
}

function findJava(mimimunVersion) {
    var java = null;
    var log = g_fs.CreateTextFile("findJava.log", true);

    try {
        java = findJavaViaRegistry(1.6))
    }
    catch (e) {
        log.WriteLine(e);
    }

}

