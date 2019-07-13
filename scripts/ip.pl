#
# Get the IP address on a Windows machine
# Bill Chatfield
#

my $found = 0;
my $line;
my $ipAddress;

if (open(IPCONFIG, "ipconfig |")) {
    while (($line = <IPCONFIG>) && (! $found)) {
        chop($line);
        if (($ipAddress) = ($line =~ /IP Address.*: (.*)$/)) {
            $found = 1;
        }
    }
    close(IPCONFIG);
    print $ipAddress, "\n";
} else {
    print STDERR $!, "\n";
}
