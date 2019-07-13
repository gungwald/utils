#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: split-contents.pl
#
#        USAGE: ./split-contents.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Bill Chatfield (bill_chatfield@yahoo.com) 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 5/13/2016 9:04:41 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

sub splitContents
{
    my ($fileHandle) = @_;
    while (<$fileHandle>) {
        chomp($_);
        my @lines = split(/;/, $_);
        foreach my $line (@lines) {
            print "$line\n";
        }
    }
}

# Main
if (@ARGV > 0) {
    foreach my $file (@ARGV) {
        if (open(INPUT, $file)) {
            splitContents(\*INPUT);
            close(INPUT);
        }
        else {
            print STDERR "$file: $!\n";
        }
    } 
}
else {
    splitContents(\*STDIN);
}





