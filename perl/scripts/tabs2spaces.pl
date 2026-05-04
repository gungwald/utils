#!/usr/bin/perl -w

# tab2spaces.pl -n2 file-name.c
# -n defines the number of spaces. Defaults to 4.

# TODO - Test -n switch
# TODO - Allow stdin to stdout pipeline filter

sub mkspc($)
{
    my ($spcCnt) = @_;
    my $spaces = "";
    for (my $i = 0; $i < $spcCnt; $i++) {
        $spaces .= " ";
    }
    return $spaces;
}
 
################
#             ##
# Main Program##
################

my $spcCnt = 4;
my $spaces = mkspc(spcCnt);
   
# Process files in place.
for $file (@ARGV) {
    my @lines;

    if ($file ~= (($sw,$num) = /^(-s|-n)(\d+)/)) {
        if ($num > 0) {
            $spcCnt = $num;
            $spaces = mkspc($spcCnt);
        }
    }    

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

