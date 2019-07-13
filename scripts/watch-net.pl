#!/usr/bin/perl

@hostsToExclude = ('ospf-all.mcast.net');

@windumpArguments = ('-i', getInterface(), 'not', 'port', '554', 'and');

foreach $host (@hostsToExclude) {
    push(@windumpArguments, "not");
    push(@windumpArguments, "host");
    push(@windumpArguments, $host);
    push(@windumpArguments, 'and');
}
pop(@windumpArguments);  # Remove unnecessary last 'and'

system('windump', @windumpArguments) == 0 || print STDERR "$!\n";
print "Please press Enter to exit $0: ";
$userInput = <STDIN>;

#
# Returns the number of the first Ethernet interface
#
sub getInterface {
    my $interface;
    my $line;
    open(WINDUMP, "windump -D |") || die "$!\n";
    while (($line = <WINDUMP>) && ! defined($interface)) {
        if ($line =~ /^(\d*)\..*Ethernet/) {
            $interface = $1;  # The matched digit
        }
    }
    close(WINDUMP);
    return $interface;
}

