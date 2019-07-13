#!/usr/bin/perl

#
# Converts UNIX-format text files with just a [line feed]
# to DOS-format text files with [carriage return] [line feed]
# Any files given on the command line are converted in place.
#
# Author:   Bill Chatfield <bill_chatfield@yahoo.com>
#
# Usage:    unix2dos unixfile1.txt [unixfile2.txt ...]
#
# Notes:    This program modifies the given files in place, rather than 
#           writing the modified file contents to standard output. So,
#           in the above "Usage" definition, "unixfile1.txt" will be
#           modified to be in DOS text format.
#

foreach $fname (@ARGV) {
    if (! -T $fname) {
        die "File '$fname' is not a text file.\n";
    }
    
    open(FILE, "< $fname") || die "Can't open '$fname' for input: $!\n";
    
    # Binary mode is required to make sure we can see all the line 
    # separator characters.
    binmode(FILE) || die "Can't set binary mode for input file '$fname': $!\n";
    
    $filesize = (stat(FILE))[7]; 
   
    $count = read(FILE, $contents, $filesize);
    close(FILE);
    
    if (!defined($count)) {
        die "Can't read from '$fname': $!\n";
    }
    elsif ($count != $filesize) {
        die "Size mismatch in input file '$fname': size=$filesize; count=$count\n";
    }
    else {
        # Change all LF chars to CR LF pairs.
        $contents =~ s/\n/\r\n/gs;
    }
    
    # Reopen to write modifed file.
    open(FILE, "> $fname") || die "Can't open '$fname' for output: $!\n";
    binmode(FILE) || die "Can't set binary mode for output file '$fname': $!\n";
    print FILE $contents;
    close(FILE);
}

