#!/usr/bin/perl

#
# CalcAvgMem.pl
# 
# Calculate average and maximum memory from tab delimited stats file.
#

my $cygwin = "C:/opt/cygwin";
my $file = $ARGV[0];
my $date = $ARGV[1];
my $total = 0;
my $count = 0;
my $avg = 0;
my $max = 0;

if (@ARGV != 1 && @ARGV != 2) {
    die "usage: $0 filename [\"Jun 30\"]\n";
}

# Determine location of gnuplot
my $gnuplot = undef;
if ($^O =~ /mswin32/i) {
    $gnuplot = "$cygwin/bin/bash -l -c \"gnuplot\"";
} else {
    $gnuplot = "gnuplot";
}

# Determine $displayDate
my $displayDate = undef;
if (defined($date)) {
    $displayDate = $date;
    $displayDate =~ s/ /-/g;
} else {
    $displayDate = "All";
}

# Determine name of graph file
my $graphName = $file;
$graphName =~ s/.txt/-$displayDate.png/;

open(GNUPLOT, "| $gnuplot") || die "$!: $gnuplot\n";
print GNUPLOT "set terminal png size 800,600\n";
print GNUPLOT "set output '$graphName'\n";
print GNUPLOT "set format x '%H:%M'\n";
print GNUPLOT "set format y '%10.0f'\n";
print GNUPLOT "set xlabel 'Time in Hours'\n";
print GNUPLOT "set ylabel 'Memory in Bytes'\n";
print GNUPLOT "set title 'Memory Usage for $displayDate'\n";
print GNUPLOT "set xdata time\n";
print GNUPLOT "set timefmt '%H:%M:%S'\n";
print GNUPLOT "plot '-' using 1:2 smooth unique title 'Memory'\n";

open(STATS, "$file") || die "$!: $file\n";
print "For dates matching '$date'\n";

while ($line = <STATS>) {
    chop($line);
    my $mem = 0;
    my @mat;
    if (defined($date)) {
        @mat = ($line =~ /^.*?\tblah\t.*?\t(.*?)\t.*?\t.*?$date (\d\d:\d\d:\d\d).*$/);
    } else {
        @mat = ($line =~ /^.*?\tblah\t.*?\t(.*?)\t.*?\t.*?... \d\d (\d\d:\d\d:\d\d).*$/);
    }
    if (@mat == 2) {
        my ($mem, $time) = @mat;
        $mem =~ s/"//g;     # Remove double quotes
        $mem =~ s/,//g;     # Remove commas
        print GNUPLOT "$time $mem\n";
        $count++;
        $total += $mem;
        if ($mem > $max) {
            $max = $mem;
        }
    }
}
close STATS;
print GNUPLOT "exit\n";
close GNUPLOT;

print "Total memory of all data points: $total\n";
print "Number of data points: $count\n";
if ($count != 0) {
    $avg = $total / $count;
}
print "Average memory: $total / $count = $avg\n";
print "Maximum memory: $max\n";

