#!/usr/bin/perl

# From: Programming Perl, 1991

# Usage: xdump [file]

open(STDIN,$ARGV[0]) || die "Can't open $ARGV[0]: $!\n" 
    if $ARGV[0];
   
# 
# Added in January 2009 by Bill Chatfield <bill_chatfield@yahoo.com>
# --
# Binary mode is required, as the default text mode in Windows translates
# any CRLF into a LF. Text mode circumvents the whole purpose of this
# program, which is to see exactly what characters are in the file;
# especially whether it is a DOS-format or UNIX-format text file.
#
binmode(STDIN) || die "Can't set binary mode on input: $!\n";
    
# Do it optimally as long as we can read 16 bytes at a time.

while (($len = read(STDIN,$data,16)) == 16) {
    @array = unpack('N4', $data);
    $data =~ tr/\0-\37\177-\377/./;
    printf "%8.8lx     %8.8lx %8.8lx %8.8lx %8.8lx     %s\n",
        $offset, @array, $data;
    $offset += 16;
}

# Now finish up the end a byte at a time.

if ($len) {
    @array = unpack('C*', $data);
    $data =~ y/\0-\37\177-\377/./;
    for (@array) {
        $_ = sprintf('%2.2x',$_);
    }
    push(@array, '  ') while $len++ < 16;
    $data =~ s/[^ -~]/./g;
    printf "%8.8lx     ", $offset;
    printf "%s%s%s%s %s%s%s%s %s%s%s%s %s%s%s%s     %s\n",
        @array, $data;
}
