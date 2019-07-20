#!/usr/bin/perl -w

my $sql = '';

while (<>) {
	chomp;
	$sql .= "'$_', ";
}

# Remove the trailing comma.
$sql =~ s/(.*), /\1/;

print $sql, "\n";

