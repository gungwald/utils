Set WSHShell = WScript.CreateObject("WScript.Shell")
Set WSHShellUserEnvironment = WSHShell.Environment("User")
DomainName = "Consonto"
User = "User1"

SET UsrObj = GETOBJECT("WinNT://" & DomainName & "/" & User & ",user")
NT4Name = replace(UsrObj.ADsPath,"WinNT://","")
tempArray = split(nt4Name,"/")
NT4Name = tempArray(1)

QueryFilter = QueryFilter & "(samAccountName=" & NT4Name & ")"
QueryString = "<LDAP://" & DomainName & ">;" & QueryFilter & ";distinguishedName;subtree"

SET ConnectionObj = CREATEOBJECT("ADODB.Connection")
SET CommandObj = CREATEOBJECT("ADODB.Command")

ConnectionObj.Provider = "ADsDSOObject"
ConnectionObj.Open "Active Directory Provider"

SET CommandObj.ActiveConnection = ConnectionObj
CommandObj.CommandText = QueryString
CommandObj.Properties("Page Size") = 900

SET Recordset = CommandObj.Execute

WHILE (NOT Recordset.EOF)
   UserDN = Recordset.Fields("DistinguishedName").Value
   wscript.Echo UserDN
   Recordset.moveNext
WEND