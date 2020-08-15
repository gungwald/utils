#!/usr/bin/perl

##############################################################################
#
# $Id$
# Copyright (c) 2002, 2003 Bill Chatfield <bill_chatfield@yahoo.com>
#
##############################################################################
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
##############################################################################
#
# Revision History:
#
# $Log$
#
##############################################################################

use Cwd;
use File::DosGlob 'glob';

# Switches
$wide = 0;

# Global counters
$fileCount = 0;
$directoryCount = 0;
$totalBytes = 0;

sub listEntry
{
    my ($entry) = @_;
    ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks)
        = stat($entry);
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($mtime);
    $year += 1900; # Year is from 1900
    $mon += 1;     # Month is 0 based
    $half = "AM";
    if ($hour > 12) {
        $hour -= 12;
        $half = "PM";
    }
    printf '%02d/%02d/%04d  %02d:%02d %s    ', $mon,$mday,$year,$hour,$min,$half;
    if (-d $entry) {
        $directoryCount++;
        print '<DIR>         ';
    } else {
        $fileCount++;
        printf '     %9s', addCommas($size);  # Need to add commas
    }
    # Regex translation: match a repetition of any non-slash character,
    # followed by an optional slash character.  Slashes, of course,
    # have to be quoted by a backslash in order to be included in the
    # pattern.
    my ($baseName) = ($entry =~ /([^\/]+)\/?$/);
    print ' ', $baseName, "\n";
    $totalBytes += $size;
}

sub listGlob
{
    my ($globArg) = @_;
    @names = glob($globArg);
    foreach $name (@names) {
        listEntry($name);
    }
}

sub listDirectory
{
    my ($directoryName) = @_;

    $outDirectoryName = getAbsoluteName($directoryName);
    $outDirectoryName =~ s/\//\\/g;
    $outDirectoryName = 'C:' . $outDirectoryName;
    print "\n Directory of ", $outDirectoryName, "\n\n";

    opendir(DIR, $directoryName) || die "$directoryName: $!\n";
    while (($entry = readdir(DIR))) {
        listEntry($directoryName . '/' . $entry);
    }
    closedir(DIR);
}

sub listFile
{
    my ($fileName) = @_;
    listEntry($fileName);
}

sub getAbsoluteName
{
    ($name) = @_;
    my $absoluteName;
    if ($name =~ /^\//) {
        $absoluteName = $name;
    } elsif ($name eq '.') {
        $absoluteName = cwd();
    } else {
        $absoluteName = cwd() . '/' . $name;
    }
    return $absoluteName;
}

sub addCommas
{
    my ($num) = @_;
    $num = reverse($num);
    $num =~ s/(\d{3})/$1,/g; # Insert the commas
    $num = reverse($num);
    $num =~ s/^,//g;         # Remove leading commas
    return $num;
}

sub isGlob
{
    my ($arg) = @_;
    my $isGlob = 0;
    if ($arg =~ /(\?|\*)/) {
        $isGlob = 1;
    }
    return $isGlob;
}

sub setSwitch
{
    my ($sw) = @_;
    $sw = uc($sw);
    if ($sw eq 'W') {
        print "WIDE\n";
        $wide = 1;
    }
}

print " Volume in drive C is Unknown\n";
print " Volume Serial Number is Unknown\n";

# Three cases for arguments:
# 1. It contains one or more switches.
# 2. It is an argument followed by one or more switches.
# 3. It is a non-switch argument.
foreach $arg (@ARGV) {
    if ($arg =~ /\//) {             # If it contains a switch.
        (@swchars) = ($arg =~ /\/([^\/]+)/g);
        if (($fileName) = ($arg =~ /(.+?)\//)) { # If there is something before the switch.
            push(@fileNames, $fileName);
        }
        foreach $sw (@swchars) {
            setSwitch($sw);
        }
    } else {
        push(@fileNames, $arg);
    }
}

if (@fileNames > 0) {
    foreach $arg (@fileNames) {
        $arg =~ s/\\/\//g;          # Replace backslashes with slashes.
        $arg =~ s/^[a-zA-Z]+://;    # Remove drive letters.
        if (isGlob($arg)) {
            listGlob($arg);
        } elsif (-d $arg) {
            listDirectory($arg);
        } else {
            listFile($arg);
        }
    }
} else {
    listDirectory('.');
}

printf "%16d File(s) %14d bytes\n", $fileCount, $totalBytes;
printf "%16d Dir(s)  %14s bytes free\n", $directoryCount, "Unknown";

