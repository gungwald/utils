
# http://www.perlmonks.org/?node_id=36684
# trim;               # trims $_ inplace
# $new = trim;        # trims (and returns) a copy of $_
# trim $str;          # trims $str inplace
# $new = trim $str;   # trims (and returns) a copy of $str
# trim @list;         # trims @list inplace
# @new = trim @list;  # trims (and returns) a copy of @list
sub trim {
	@_ = $_ if not @_ and defined wantarray;
	@_ = @_ if defined wantarray;
	for ( @_ ? @_ : $_ ) { s/^\s+//, s/\s+$// }
	return wantarray ? @_ : $_[0] if defined wantarray;
}

foreach my $name (@ARGV) {
	open( IN, $name ) || die "$name: $!\n";
	my $lineNum     = 0;
	my $prevMatlNum = "";
	my $prevGtin    = "";
	my $sameCounter = 0;
	while (<IN>) {
		$lineNum++;
		my ( $matlNum, $gtin ) = trim( split(/,/) );
		if ( $matlNum eq $prevMatlNum ) {
			if ( $gtin eq $prevGtin ) {
                $sameCounter++;
			}
			else {
				printf( "%d: %s==%s and %s!=%s\n", $lineNum, $matlNum, $prevMatlNum, $gtin, $prevGtin );
			}
		}
		$prevMatlNum = $matlNum;
		$prevGtin    = $gtin;
	}
	close(IN);
	printf("Number of Material Numbers with the same GTIN: %d\n", $sameCounter);
}
