// Gets the current user's 'uid' property from Active Directory. The 'uid' 
// property is the 8-character userid used for logging in to a UNIX/Linux
// system. Invoke as "cscript //nologo uid.js" to programmatically read
// the output. - Bill Chatfield <bill_chatfield@yahoo.com>
var activeDirectory = new ActiveXObject("ADSystemInfo");
var userName = activeDirectory.UserName;
var userUrl = "LDAP://" + userName;
var user = GetObject(userUrl);
var uid = user.uid;
WScript.Echo(uid);

