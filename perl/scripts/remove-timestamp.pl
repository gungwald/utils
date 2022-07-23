#!/usr/bin/env perl

while (<>) {
	($timestamp, $rest) = /(\[[ \.\d]+\]\s*){0,1}(.*)/;
	#print "timestamp=$timestamp rest=$rest\n";
	print "$rest\n";
}
