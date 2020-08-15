#!/usr/bin/perl

foreach $arg (@ARGV) {
    $prevLine = '';
    open(IN, $arg) || die "$arg: $!\n";
    while ($line = <IN>) {
        if ($line =~ /java\.lang\.String message="\[NCR\] \[Teradata JDBC Driver\] : HY000 802 : Timeout"/) {
            $date = substr($prevLine, 0, 17);
            $line = <IN>;
            $line = <IN>;
            $line = <IN>;
            ($className) = ($line =~ /^.*at (.*)\..*$/);
            print $date, "\t", $className, "\n";
        }
        $prevLine = $line;
    }
}

