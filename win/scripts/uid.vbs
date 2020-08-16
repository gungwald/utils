WScript.Echo GetObject("LDAP://" & CreateObject("ADSystemInfo").UserName).uid
