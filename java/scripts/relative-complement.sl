#
# Finds the relative complement of two sets (aka set difference).
# Sets are files where each line is a set element.
#

sub readFileIgnoreBlanks
{
    local('@lines');
    @lines = @();
    while $line (readln($1)) {
        # Ignore whitespace and non-breaking spaces.
        if ($line !ismatch '\s*|\xA0*') {
            push(@lines, $line);
        }
    }
    return @lines;
}

#
# Removes blank entries in an array.
#
sub removeBlankLines
{
    foreach $line ($1) {
        if ($line eq "") {
            remove();
        }
    }
    return $1;
}    

if (size(@ARGV) != 2) {
    println();
    println("Usage: relative-complement file1 file2");
    println();
    println("    Computes line-by-line difference: file1 \\ file2");
    println("    https://en.wiktionary.org/wiki/relative_complement");
    println();
    exit();
}

$fileNameA = @ARGV[0];
$fileNameB = @ARGV[1];

$fileA = openf($fileNameA);
if ($fileA) {
    @a = readFileIgnoreBlanks($fileA);
    closef($fileA);
}
else {
    exit("Failed to open: $fileNameA: $error");
}

$fileB = openf($fileNameB);
if ($fileB) {
    @b = readFileIgnoreBlanks($fileB);
    closef($fileB);
}
else {
    exit("Failed to open: $fileNameB: $error");
}

@relativeComplement = removeAll(@a, @b);	# @a is also modified

foreach $element (@relativeComplement) {
    println($element);
}

