//
// mbam-watchdog.js - Display an error any time Malwarebytes is shut off.
// 

/** Locates the service we want to use. @type SWbemLocator */
var locator = new ActiveXObject("WbemScripting.SWbemLocator");

/** Used to look up process information. @type SWbemServices */
var service;

/** Stores results of processes query. @type SWbemObjectSet */
var processCollection;

/** Enumerates process objects in processCollection. @type Enumerator */
var processes;

/** Stores one process object. @type SWbemObject */
var process;

var watchedProcess = "mbamservice.exe";
var waitInterval = 60000;   // 60000 milliseconds = 1 minute
var found;

// Loop forever, checking for watchedProcess every waitInterval.

while (true) {
    
    service = locator.ConnectServer(".", "root\\cimv2");
    processCollection = service.ExecQuery("select * from Win32_Process");
    processes = new Enumerator(processCollection);
    found = false;

    while (! processes.atEnd()) {
        process = processes.item();
        if (process.Name == watchedProcess) {
            found = true;
            break;
        }
        processes.moveNext();
    }

    if (! found) {
        WScript.Echo("Malwarebytes Anti-Malware ERROR !!!!!\n\nIt is not resident in memory. Something has turned it off. You must turn this feature back on to be protected.");
    }

    WScript.Sleep(waitInterval);
}
