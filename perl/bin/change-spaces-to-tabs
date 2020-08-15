#!/usr/bin/env perl

# Change indentation to use tabs.

use File::Basename qw(basename dirname);
use File::Copy qw(copy);
use File::Spec::Functions qw(catfile catdir);

my $backupDir = catdir($ENV{USERPROFILE}, '.backups');
if (! -d $backupDir) {
    mkdir($backupDir) || die "Failed to create backup directory: $!\n";
}

# Process all commmand line arguments.
for $file (@ARGV) {
    my @lines;
    
    # Backup file
    copy($file, $backupDir) || die "Backup failed: $!\n";
    
    # Read in file
    open(IN, $file) || die "$file: $!\n";
    while (<IN>) {
        # Get all the whitespace at the beginning of the line.
        my ($indent, $code) = m/^(\s*)(.*)$/;
        # Substitute a tab for each 4 spaces.
        $indent =~ s/    /\t/g;
        push(@lines, "$indent$code\n");
    }
    close(IN);

    # Write out file with spaces instead of tabs.
    open(F, "> $file") || die "$file: $!\n";
    for (@lines) {
        print F $_;
    }
    close(F);
}
