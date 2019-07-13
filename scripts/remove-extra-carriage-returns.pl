#!/usr/bin/perl

for $f (@ARGV) {
    $bak = "$f.bak";
    rename($f, $bak) || die "$f: $!\n";
    print "Renamed $f to $bak\n";
    open(IN, $bak) || die "$bak: $!\n";
    binmode(IN) || die "Can't set binary mode on input: $!\n";
    open(OUT, ">$f") || die "$f: $!\n";
    print "Recreating $f\n";
    while (<IN>) {
        s/\r\r\n/\r\n/g;
        print OUT;
    }
    close(OUT);
    close(IN);
}

