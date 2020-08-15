// This only works in the Nashorn JavaScript engine of Java 1.8, not the old 
// Rhino engine of earlier releases.

// Import Java classes
importClass(Packages.java.util.GregorianCalendar)
var GregorianCalendar = Java.type("java.util.GregorianCalendar")
var Calendar          = Java.type("java.util.Calendar")
var TimeZone          = Java.type("java.util.TimeZone")
var String            = Java.type("java.lang.String")

var cal = new GregorianCalendar(TimeZone.getTimeZone("GMT"))
print(String.format("%02d:%02d GMT", cal.get(Calendar.HOUR_OF_DAY), cal.get(Calendar.MINUTE)))