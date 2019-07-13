#
#   lookuphosts.pl - Looks up all hosts in a hosts file
#
use English '-no_match_vars';
use Net::hostent 'gethost';
use Socket 'inet_ntoa';

sub isRegularComment($);
sub isMyComment($);
sub writeCommentForLine($);

my $myCmt = "#- ";

# Checks if the argument count is 0.
if (scalar(@ARGV) == 0) {
	push(@ARGV, $ENV{'SystemRoot'}."\\system32\\drivers\\etc\\hosts");
}

foreach $file (@ARGV) {
    open(HOSTS, $file) || die "$PROGRAM_NAME: $file: $!\n";
    $lineCount = 0;
    while ($line = <HOSTS>) {
        $lineCount++;
        chomp($line);                   # Remove line separator
        $line =~ s/^\s*(.*?)\s*$/$1/;   # Trim whitespace from both ends
        
        # Old my comment lines are not included in the output.
        if (!isMyComment($line)) {
            if ($line eq '' || isRegularComment($line)) {
                # Pass these through without changes.
                print "$line\n";
            }
            else {
                # This is not a blank line or a comment line.
                # It should be a data line.
                writeCommentForLine($line);
            }
        }
    }
    close(HOSTS);
}

sub isRegularComment($)
{
    my ($line) = @_;
    
    return substr($line,0,1) eq '#';
}

sub isMyComment($)
{
    my ($line) = @_;
    
    return substr($line,0,length($myCmt)) eq $myCmt;
}

sub writeCommentForLine($)
{
    my ($line) = @_;
    
    @names = split(/\s+/, $line);
    $h = gethost($names[1]);
    		
	print "$myCmt\n$myCmt\n$myCmt Forward lookup: ";
 	if ($h) {
        print $h->name, "\n$myCmt\n";
    		    
        print "$myCmt Aliases:        ";
        if (@{$h->aliases}) {
            foreach $alias (@{$h->aliases}) {
                print "$alias\n";
                print "$myCmt                 ";
            }
        }
        else {
            print "None\n$myCmt";
        }
        print "\n";
    		    
        print "$myCmt Addresses:      ";
        foreach $addr (@{$h->addr_list}) {
            print inet_ntoa($addr), "\n"; 
            print "$myCmt                 ";
        } 
        print "\n";
    }
    else {
        print "Not found\n$myCmt\n";
    }
    $h = gethost($names[0]);
    		
    print "$myCmt Reverse lookup: ";
    if ($h) {
        print $h->name, "\n";
        print "$myCmt                 ";
    }
    else {
        print "Not found\n$myCmt";
    }
    print "\n$myCmt\n", join(' ', @names), "\n";
}
