// Gets the current user's distinguished name property from Active Directory.
// Invoke as "cscript //nologo dn.js" to programmatically read
// the output. - Bill Chatfield <bill_chatfield@yahoo.com>
var activeDirectory = new ActiveXObject("ADSystemInfo");
var userName = activeDirectory.UserName;
WScript.Echo(userName);
var userUrl = "LDAP://" + userName;
var user = GetObject(userUrl);
WScript.Echo(user);
var dn = user.dn;
WScript.Echo(dn);
