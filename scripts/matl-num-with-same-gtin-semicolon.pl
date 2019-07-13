use File::Basename;

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

# Infinite page length
#$= = 0;

my $arg;
my $name;
my $lineNum;
my $matl;
my $gtin;
my $recNum;
my $type;
my $rest;
my $sameCounter = 0;

format STDOUT_TOP =
 LINE NUM  MATL                 GTIN
.

format STDOUT =
@>>>>>>>>  @<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<
$lineNum,  $matl,               $gtin
.
sub resolveGlobPatterns(@)
{
    my @resolvedArgs = ();
    for (@_) {
        if (/\*/) {
            push(@resolvedArgs, glob($_));
        }
        else {
            push(@resolvedArgs, $_);
        }
    }
    return @resolvedArgs;
}

my @args = resolveGlobPatterns(@ARGV);

for $name (@args) {
	open( IN, $name ) || die "$name: $!\n";
	printf("\nFile: %s\n\n", $name);
	$lineNum = 0;
	my $prevMatlNum = "";
	my $prevGtin    = "";
	while (<IN>) {
		$lineNum++;
		( $recNum, $matl, $type, $gtin, $rest ) = trim( split(/;/) );
		if ( $matl eq $prevMatlNum ) {
			if ( $gtin ne '' && $gtin eq $prevGtin ) {
                $sameCounter++;
				write STDOUT;
			}
		}
		$prevMatlNum = $matl;
		$prevGtin    = $gtin;
	}
	close(IN);
}

printf("\nTotal number of material numbers with the same GTIN: %d\n", $sameCounter);
