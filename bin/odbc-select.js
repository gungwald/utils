// Create a 32-bit ODBC data source named DUBLIN3
// Run with: cscript as400.js
var conn = new ActiveXObject("ADODB.Connection");
conn.ConnectionString="dsn=DUBLIN3;uid=CAHHADOOP;pwd=ibmy25yrs$;";
conn.Open();
var rs = new ActiveXObject("ADODB.Recordset");
rs.Open("select \"CCRGNID\",\"CCRGNNM\" from ccdbrepdta.ccregn",conn);
while(!rs.EOF) {
    WScript.StdOut.WriteLine(rs("ccrgnid") + "\t" + rs("ccrgnnm"));
    rs.MoveNext;
}
rs.Close();
conn.Close();

