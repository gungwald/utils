// Run with this command:
//
// java -jar js.jar tz.js

importClass(java.text.SimpleDateFormat);

var formatter = new SimpleDateFormat("zzzz (Z)");
var now = new java.util.Date(); // Cannot import Date because of JavaScript's Date object.
var timezone = formatter.format(now);
print(timezone);
