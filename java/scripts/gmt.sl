import java.util.GregorianCalendar;
import java.util.Calendar;
import java.util.TimeZone;

$cal = [new GregorianCalendar: [TimeZone getTimeZone: "GMT"]];
println([$cal get: [Calendar HOUR_OF_DAY]] . ":" . [$cal get: [Calendar MINUTE]] . " GMT");
