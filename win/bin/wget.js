if (typeof WScript === 'undefined' && typeof arguments !== 'undefined') {
    print("This is a Window Script Host script. It won't work with Java.");
    quit();
}
var Source = WScript.Arguments.Item(0); 
var Target = WScript.Arguments.Item(1); 
var http = WScript.CreateObject('MSXML2.ServerXMLHTTP'); 
WScript.Echo("Source URL = " + Source); 
WScript.Echo("Target File = " + Target); 
http.open('GET', Source, false); 
http.send(); 
if (http.status == 200) { 
   var Stream = WScript.CreateObject('ADODB.Stream'); 
   Stream.Open(); 
   Stream.Type = 1; // adTypeBinary 
   Stream.Write(http.responseBody); 
   Stream.Position = 0; 
   var File = WScript.CreateObject('Scripting.FileSystemObject'); 
   if (File.FileExists(Target)) { 
       File.DeleteFile(Target); 
   } 
   Stream.SaveToFile(Target, 2); // adSaveCreateOverWrite 
   Stream.Close(); 
} 
else { 
   WScript.Echo("Download failed with HTTP code: " + http.status); 
} 
