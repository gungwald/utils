#!/usr/bin/perl

# Remove first command line argument and store it in $regexp.
$regexp = shift(@ARGV);

# Make the record separator a carriage return followed by two new lines.
# This is the separator between error messages in our Java logs. This will
# effectively make Perl read a single message at a time, even though it
# spans multiple lines. Now we can match across lines within the same error
# message. To do this one must match the new line which separates lines
# within one message, like this: 07/19/07.*\n.*something. 
$/ = "\r\n\n";

$matchingMessageCount = 0;


# Iterate over every line of every file specified on the command line.
while (<ARGV>) {
    # Match what we were given as the first command line argument.
    if (/$regexp/sm) {  # If a match occurred
        # Record this match.
        $matchingMessageCount++;
        
        # Print the whole message, prefixed by file name.
        # Retain the silly end of message so this script will work again on
        # the results.
        print "$ARGV: $_";
    }
}

# Report total matching lines.
print "Total matching messages: $matchingMessageCount\n";

