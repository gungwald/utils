# Outputs elements of the PATH line by line.

my $varName;

if (scalar(@ARGV) < 1) {
    push(@ARGV, 'Path');
}

foreach $arg (@ARGV) {

    $path = $ENV{$arg};
    if (defined($path)) {
        @parts = split(/;/, $path); 
    }
    
    foreach $part (@parts) {
        print $part, "\n";
    }
}

