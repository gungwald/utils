#!/usr/bin/perl -w

# tab2spaces.pl -n2 file-name.c
# -n defines the number of spaces. Defaults to 4.

sub makeSpaces($)
{
    my ($spaceCount) = @_;
    my $spaces = "";
    for (my $i = 0; $i < $spaceCount; $i++) {
        $spaces .= " ";
    }
    return $spaces;
}

sub doStdio($){
    my ($spaces) = @_;
    while (<STDIN>) {
        s/\t/$spaces/g;
        print;
    }
}

sub usage()
{
    my $pgm = `basename \"$0\"`;
    chomp($pgm);
    print "\n";
    print "Usage:\n";
    print "\n";
    print "$pgm [-n<space-count>] [-O] <file-name>\n";
    print "\n";
    print "    -n space-count is number of spaces.\n";
    print "       It defaults to 4.\n";
    print "    -O Write output to standard output.\n";
    print "       This is consistent with dos2unix.\n";
    print "\n";
    print "    file-name: files are modified in place\n";
    print "        unless the -O switch is provided.\n";
    print "        It can be - to read from stdin.\n";
    print "\n";
    exit(0);
}
 
################
#             ##
# Main Program##
################

my $spaceCount = 4;
my $spaces = makeSpaces($spaceCount);
my $fileWasProvided = 0;
my $writeToStdout = 0;
   
# Process files in place.
for $file (@ARGV) {
    my @lines;
    my $sw;
    my $num;

    if (($sw,$num) = ($file =~ /^(-s|-n)(\d+)/)) {
        if ($num > 0) {
            $spaceCount = $num;
            $spaces = makeSpaces($spaceCount);
        }
    } elsif ($file =~ /--help|-h|-\?|\/\?|\/h|\/help/) {
        usage();
    } elsif ($file eq '-O') {
        $writeToStdout = 1;
    } elsif ($file eq '-') {
        $fileWasProvided = 1;
        doStdio($spaces);
    } else {
        $fileWasProvided = 1;

        if ($writeToStdout) {
            # Read in file
            open(IN, $file) || die "$file: $!\n";
            while (<IN>) {
                # Substitute spaces for each tab.
                s/\t/$spaces/g;
                # Write to stdout.
                print;
            }
            close(IN);
        } else {
            # Modify file in place - the default
            
            # Read in file
            open(IN, $file) || die "$file: $!\n";
            while (<IN>) {
                # Substitute spaces for each tab.
                s/\t/$spaces/g;
                push(@lines, $_);
            }
            close(IN);


            # Write out file with spaces instead of tabs.
            open(F, "> $file") || die "$file: $!\n";
            for (@lines) {
                print F $_;
            }
            close(F);
        }
    }
}

if (! $fileWasProvided) {
    doStdio($spaces);
}
