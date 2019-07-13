#!/usr/bin/perl

use File::Copy;

if (@ARGV > 0) {
    for $f (@ARGV) {
        $bak = "$f.bak";
        copy($f, $bak) || die "$f: $!\n";
        print "Created backup $bak\n";
        open(IN, $bak) || die "$bak: $!\n";
        open(OUT, ">$f") || die "$f: $!\n";
        print "Modifying original $f\n";
        while (<IN>) {
            s/\^M$//;
            print OUT;
        }
        close(OUT);
        close(IN);
    }
}
else {
    while (<>) {
        s/\^M$//;
        print $_;
    }
}

