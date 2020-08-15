#!/usr/bin/perl

# Set the record (line) separator to be Windows compatible
#$/ = "\r\n";

$find = shift(@ARGV);
$replace = shift(@ARGV);

print "Find = [$find]\n";
print "Replace = [$replace]\n";

#$findDisplay = $find;

#if ($findDisplay eq "\t") {
#    $findDisplay = "TAB";
#}

#print "Replace [$find] with [$replace] in remaining args? ";
#$response = <STDIN>;

#if ($response eq 'n' || $response eq 'N') {
#    die "Canceling\n";
#}

foreach $f (@ARGV) {
    print "File = $f\n";
    if (-w $f) {
    	$orig = "$f.orig";
    	system("cmd", "/c", "copy", "/y", $f, $orig, ">nul:");
    	open(IN, $orig) || die "$0: $orig: $!\n";
    	open(OUT, "> $f") || die "$0: $f: $!\n";
    	while (<IN>) {
            s/$find/$replace/g;
            print OUT $_;
    	}
    	close(OUT);
    	close(IN);
    }
    else {
	print "$0: $f: File does not exist or is not writable\n";
    }
}

1;
