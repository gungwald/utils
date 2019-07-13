#!/usr/bin/perl

#
#   fix-tabs-in-makefile.pl
#   Copyright (c) 2012, 2016 Bill.Chatfield@yahoo.com
#   Distributed under the GPL
#

# If there are no arguments, then add the default.
if (@ARGV == 0) {
	push(@ARGV, "Makefile");
}

foreach $makefile (@ARGV) {
	# Read all the lines into memory.
	open(MAKEFILE, $makefile) || die "$0: $makefile: $!\n";
	@lines = <MAKEFILE>;
	close(MAKEFILE) || die "$0: $makefile: $!\n";
	
	# Write it back out with the tabs added.
    open(MAKEFILE, ">$makefile") || die "$0: $makefile: $!\n";	
	foreach (@lines) {
		# Match 4 or more spaces at the beginning of a line.
		# Replace them with a tab.
		s/^\s+(.*)/\t$1/;
		print MAKEFILE $_;
	}
    close(MAKEFILE) || die "$0: $makefile: $!\n";	
}
