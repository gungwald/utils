#!/usr/bin/perl

foreach my $pattern (@ARGV) {
    foreach my $elem (split(/:/, $ENV{PATH})) {
        if (-d $elem) {
            chdir($elem);
            my @matches = glob("*$pattern*");
            if (@matches) {
                print "\n$elem:\n\n";
                foreach my $match (@matches) {
                    print "$match\n";
                }
            }
        }
    }
}