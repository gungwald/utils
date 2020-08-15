#
# Search and Replace an entire file, line by line.
#
use Win32;

# Check for correct arguments.
if (scalar(@ARGV) < 3) {
    print "usage: $0 [Perl search pattern] [replacemet] [file name]\n";
    exit(1);
}

# Assign command line arguments to variables.
my ($searchPattern, $replacePattern, $fileName, $rest) = @ARGV;

# Read in the complete input file.
open(IN, $fileName) || die "$!: $fileName\n";
my @lines = <IN>;
close(IN);

# Make a backup copy of the input/output file.
my $backupName = "$fileName.bak";
my $attemptCnt = 1;
my $fileExistsErrorCode = 80;
my $noOverwrite = 0;
while (! Win32::CopyFile($fileName, "$backupName$attemptCnt", $noOverwrite)) {
    my $errnum = Win32::GetLastError();
    if ($errnum == $fileExistsErrorCode) {
        $attemptCnt++;
    }
    else {
        my $errstr = Win32::FormatMessage($errnum);
        $errstr =~ s/[\r\n]/ /gs;
        print STDERR "Backup failed: Win32 error code = $errnum: $errstr\n";
        exit(1);
    }
}

# Overwrite the input file with the search & replace operations completed.
open(OUT, "> $fileName") || die "$!: $fileName\n";
foreach $line (@lines) {
    $line =~ s/$searchPattern/$replacePattern/gi;
    print OUT $line;
}
close(OUT);
