if (WScript.Arguments.length > 0) {
    var userid = WScript.Arguments(0);
    var conn = WScript.CreateObject("ADODB.Connection")
    var rootDSE = GetObject("LDAP://RootDSE");
    var context = rootDSE.Get("defaultNamingContext");

    conn.Provider = "ADsDSOObject";
    conn.Open("ADs Provider");

    var query = "<LDAP://" + context + ">;(&(&(objectCategory=person)(objectClass=user))samAccountName=" + userid + ");samAccountName;subtree";
    var cmd = WScript.CreateObject("ADODB.Command");

    cmd.ActiveConnection = conn;
    cmd.CommandText = query;
    cmd.Properties.Item("SearchScope") = 2;
    cmd.Properties.Item("Page Size") = 500;

    var r = cmd.Execute();
    var userExists = false;
    
    while (! r.EOF) {
        var e = new Enumerator(r.Fields);
        while (! e.atEnd()) {
            userExists = true;
            WScript.Echo(e.item() + " exists.");
            //WScript.Echo(e.item().name + "=" + e.item().value);
            e.moveNext();
        }
        r.MoveNext();
    }

    if (! userExists) {
        WScript.Echo(userid + " does not exist.");
    }
}
else {
    WScript.Echo("Specify a userid on the command line.");
}


