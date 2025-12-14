#!/usr/bin/perl

use File::Spec::Functions 'path', 'rel2abs'; # Makes script cross-platform

foreach my $pattern (@ARGV) {
    foreach my $dir (path()) {
        if (-d $dir) {
            chdir($dir);
            foreach my $match (glob("*$pattern*")) {
                print rel2abs($match), "\n";
            }
        }
    }
}