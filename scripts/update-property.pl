#
# Set a parameter value in a config file.
# Bill Chatfield
#

if (@ARGV != 3) {
    usage();
    exit(1);
}

my $fileName = $ARGV[0];
my $paramName = $ARGV[1];
my $value = $ARGV[2];
my $line;
my @lines;
my $found = 0;

if (open(CONFIG, $fileName)) {
    while (($line = <CONFIG>)) {
        if ($line =~ /^$paramName\=/) {
            print "Replacing line:\n";
            print "\t$line\n";
            print "with:\n";
            $line = $paramName . '=' . $value . "\n";
            print "\t$line\n";
            $found = 1;
        }
        push(@lines, $line);
    }
    close(CONFIG);
    if ($found) {
        if (open(CONFIG, "> $fileName")) {
            print CONFIG @lines;
            close CONFIG;
        } else {
            print STDERR $!;
        }
    } else {
        print "No parameter named ", $paramName, " found in ", $fileName, "\n";
    }
} else {
    print STDERR $!;
}

sub usage() {
    print "SetParameter.pl <fileName> <paramName> <value>\n"
}

