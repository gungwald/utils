#!/usr/bin/perl

# Bill Chatfield
# Java Log File Editor

if (@ARGV != 2) {
    print "Give me a file name and a pattern to match the first line of the stack trace.\n";
    exit(1);
}

$fileName = $ARGV[0];
$pattern = $ARGV[1];

open(FILE, "$fileName") || die "$fileName: $!\n";

while ($line = <FILE>) {
    chop($line);
    if ($line =~ /$pattern/) {
        $endOfStackTrace = 0;
        while (! $endOfStackTrace) {
            if (! ($stackTraceLine = <FILE>)) {
                exit(0);
            }
            chop($stackTraceLine);
            if ($stackTraceLine =~ /^\s*$/) {
                # It is only whitespace
                $endOfStackTrace = 1;
            }
        }
    } else {
        print STDOUT "$line\n";
    }
}

