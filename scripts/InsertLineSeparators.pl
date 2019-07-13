#
# InsertLineSeparators.pl
# Bill Chatfield
# December 9, 2007
# 

# Iterate over every line of every file specified on the command line.
while (<ARGV>) {
    s/  at /\n$&/gs;					# Cont'd stack traces
    s/\[\w\w\w /\n$&/gs;				# Time-stamped messages
    s/(\w\. )(\w)/$1\n$2/gs;				# Plain messages
    s/\.\.\. (\d)* more /\n\n$&\n\n/gs;			# Repeat messages
    s/There are no listeners for (\S)* /\n$&\n/gs;	# Listener messages
    s/ false /$&\n/gs;					# Status messages
    s/ true /$&\n/gs;					# Status messages
    s/ \|false\| /$&\n/gs;				# Status messages
    s/ \|true\| /$&\n/gs;				# Status messages
    print $_;
}
