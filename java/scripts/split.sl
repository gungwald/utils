#
# Splits multiple userids on one line into separate lines.
#

foreach $arg (@ARGV) {
    $f = openf($arg);
    if ($f) {
        while $line (readln($f)) {
            @words = split(' ', $line);
            foreach $word (@words) {
                println($word);
            }
        }
        closef($f);
    }
    else {
        exit("Could not open file: $arg: $error");
    }
}
