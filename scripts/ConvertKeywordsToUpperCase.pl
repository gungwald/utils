# ConvertKeywordsToUpperCase.pl
# 
# Converts Modula-2 keywords to upper case so the programmer doesn't have to
# constantly switch case when originally typing in the program.
# 

my @keywords = ('and', 'array', 'begin', 'by', 'case', 'const', 'definition',
             'div', 'do', 'else', 'elsif', 'end', 'except', 'exit', 
             'export', 'finally', 'for', 'forward', 'from', 'if',
             'implementation', 'import', 'in', 'loop', 'mod', 'module',
             'not', 'of', 'or', 'packedset', 'pointer', 'procedure',
             'qualified', 'record', 'repeat', 'rem', 'retry', 'return',
             'set', 'then','to', 'type', 'until', 'var', 'while', 'with',
            
             'cardinal', 'char', 'integer', 'real');

sub convertLine($)
{
    my ($line) = @_;
    foreach my $keyword (@keywords)
    {
        my $upperCaseKeyword = uc($keyword);
        $line =~ s/\b$keyword\b/$upperCaseKeyword/ig;
    }
    return $line;
}
                
sub convertFile($)
{
    my ($fileName) = @_;
    open(TOCONVERT, $fileName) || die "Failed to open $fileName: $!\n";
    my @lines = <TOCONVERT>;
    close(TOCONVERT);

    open(CONVERTED, "> $fileName") || die "Failed to open $fileName for writing: $!\n";
    my $convertedLine;
    foreach my $line (@lines) 
    {
        $convertedLine = convertLine($line);
        print CONVERTED $convertedLine;
    }
    close(CONVERTED);
}

foreach my $arg (@ARGV) 
{
    convertFile($arg);
}
