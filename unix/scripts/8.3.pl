#!/usr/bin/perl

#############################################################################
#
# 8.3.pl
# Copyright (c) 2008 - Bill Chatfield <bill_chatfield@yahoo.com>
# All rights reserved.
#
# Distributed under the GNU General Public License (GPL) 
#
#############################################################################

#############################################################################
#
# Prints full path to file using short versions of file and 
# directory names.
#
#############################################################################

use Win32;
use English '-no_match_vars';  # Allow long form of built-in variable names

sub isRunningInCygwin();
sub ensureWindowsFormatPath($);
sub getShortPathName($);

# If there are no arguments, then assume the current working directory.
if (@ARGV == 0) {
    push(@ARGV, '.');
}

for $arg (@ARGV) {
    if (isRunningInCygwin()) {
        $arg = ensureWindowsFormatPath($arg);
    }
    $fullName = Win32::GetFullPathName($arg);
    if (defined($fullName)) {
        if (isRunningInCygwin()) {
            $fullShortName = getShortPathName($fullName);
        }
        else {
            $fullShortName = Win32::GetShortPathName($fullName);
        }
        if (defined($fullShortName)) {
            print "$fullShortName\n";
        }
        else {
            print "GetShortPathName failed for '$arg': ", Win32::FormatMessage(Win32::GetLastError()), "\n";
        }
    }
    else {
        print "GetFullPathName failed for '$arg': ", Win32::FormatMessage(Win32::GetLastError()), "\n";
    }
}

sub getShortPathName($)
{
    my $path = `cygpath --dos "$_[0]"`;
    chomp($path);
    return $path;
}

sub ensureWindowsFormatPath($)
{
    my $path = `cygpath --windows "$_[0]"`;
    chomp($path);
    return $path;
}

sub isRunningInCygwin()
{
    return $OSNAME =~ /cygwin/i;
}
