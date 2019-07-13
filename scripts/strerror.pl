#
#   Displays a Win32 error message given the error code from getLastError.
#
use English '-no_match_vars';
use File::Basename 'basename';

foreach $arg (@ARGV) {
    if ($arg =~ /^\d+$/) {
        $EXTENDED_OS_ERROR = $arg;
        if ("$EXTENDED_OS_ERROR" ne "$arg") {
            print "Error code $arg is \"$EXTENDED_OS_ERROR\"\n";
        }
        else {
            print STDERR basename($0), ": $arg is not a recognized error code\n";
        }
    }
    else {
        print STDERR basename($0), ": $arg is not a number\n";
    }
}
