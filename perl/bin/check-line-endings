#!/usr/bin/perl

#
# Determines what the type of the file is.
#
# Author:   Bill Chatfield <bill_chatfield@yahoo.com>
#
# Usage:    checkfiletype file1 [file2 ...]
#

foreach $fname (@ARGV) {
    if ( -T $fname ) {
        open( FILE, $fname ) || die "Can't open file: $fname: $!\n";
        binmode(FILE) || die "Can't set binary mode for file: $fname: $!\n";
        $line = <FILE>;
        close(FILE);
        if ( $line =~ /\r\n$/ ) {
            print $fname, ": DOS text\n";
        }
        elsif ( $line =~ /\r$/ ) {
            print $fname, ": legacy Mac text\n";
        }
        elsif ( $line =~ /\n$/ ) {
            print $fname, ": UNIX text\n";
        }
    }
    else {
        print $fname, ": binary\n";
    }
}
