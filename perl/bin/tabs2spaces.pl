# Process all commmand line arguments.
for $file (@ARGV) {
    my @lines;
    
    # Read in file
    open(IN, $file) || die "$file: $!\n";
    while (<IN>) {
        # Substitute 4 spaces for each tab.
        s/\t/    /g;
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

