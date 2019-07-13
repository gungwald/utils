#!/usr/bin/perl

foreach my $file (@ARGV) {
	open(INPUT, $file) || die "$0: $file: $!\n";
	my $lineNumber = 1;
	my $headers = <INPUT>;
	print $headers;
	while (<INPUT>) {
		$lineNumber++;
		my ($dataLineNumber, $fields) = /(\d*)\s*;(.*)/;
		if ($dataLineNumber && $fields) {
			print $dataLineNumber, ',', $fields;
		}
		else {
			print STDERR "$0: $file: Invalid line at $lineNumber: $_\n";
		}
	}
	close(INPUT);
}
