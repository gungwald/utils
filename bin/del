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

# Because of File::DocGlob
require 5.004;

# override CORE::glob in current package
use File::DosGlob 'glob';
use Cwd;
use Errno;

$promptForConfirmation = 0;
$forceReadOnly = 0;
$deleteFilesInSubdirectories = 0;
$quiet = 0;
$attributes = 0;
$attrReadOnly = 0;
$attrHidden = 0;
$attrSystem = 0;
$attrArchive = 0;
$invertAttributes = 0;

foreach (@ARGV) {
    if (/^\//) { # It begins with the switch character
        @params = /\/(.)/g; # Geta all switches in this argument
        foreach (@params) {
            $param = lc($_);
            if ($param eq 'p') {
                $promptForConfirmation = 1;
            } elsif ($param eq 'f') {
                $forceReadOnly = 1;
            } elsif ($param eq 's') {
                $deleteFilesInSubdirectories = 1;
            } elsif ($param eq 'q') {
                $quiet = 1;
            } elsif ($param eq '?') {
                usage();
                exit(0);
            } elsif ($param eq 'a') {
                $attributes = 1;
                ($attrs) = /\/a(.*)\/?/i;
                @attrChars = split(/ */, $attrs);
                foreach (@attrChars) {
                    $attr = lc($_);
                    if ($attr eq 'r') {
                        $attrReadOnly = 1;
                    } elsif ($attr eq 'h') {
                        $attrHidden = 1;
                    } elsif ($attr eq 's') {
                        $attrSystem = 1;
                    } elsif ($attr eq 'a') {
                        $attrArchive = 1;
                    } elsif ($attr eq '-') {
                        $invertAttributes = 1;
                    }
                }
            }
        }
    } else {
        push(@fileArgs, $_);
    }
}

foreach $arg (@fileArgs) {
    # Real del will not delete any files in arg list in the same directory up
    # to the wildcard if the user says no to the prompt.
    if ($arg eq '*.*' || $arg eq '*') {
        if (! $quiet) {
            if (! promptForGlobalWildcard($arg)) {  # Diff from real del.
                next;
            }
        }
    }
    @fileNames = glob($arg); # Actually a DosGlob
    foreach $fileName (@fileNames) {
        deleteWhatever($fileName);
    }
}

sub deleteWhatever
{
    my ($whatever) = @_;
    if (-d $whatever && $deleteFilesInSubdirectories) {
        deleteDirectory($whatever);
    } else {
        deleteFile($whatever);
    }
}

sub deleteDirectory
{
    my ($directoryName) = @_;
    if (opendir(DIR, $directoryName)) {
        while ($fileName = readdir(DIR)) {
            if ($fileName ne '..' && $fileName ne '.') {
                deleteWhatever($fileName);
            }
        }
        closedir(DIR);
    }
}

sub deleteFile
{
    my ($fileName) = @_;
    my $numRemoved = 0;

    if ($promptForConfirmation) {
        if (! promptForConfirmation($fileName)) {
            return;
        }
    }

    if (! -w $fileName) { # if it is read-only
        if (! $forceReadOnly) {
            print cwd(), "\\$fileName\n";
            print "Access is denied.\n";
            # Strangely errorlevel is still 0 in this case.
            return;
        }
    }

    $numRemoved = unlink($fileName);

    if ($numRemoved == 0) {
        print "$fileName: $!\n";
        # Set exit value...
    }
}

sub promptForConfirmation
{
    my ($fileName) = @_;
    my $prompt = 0;
    print cwd(), '\\', $fileName, ', Delete (Y/N)? ';
    $response = <STDIN>;
    if ($response eq 'y' || $response eq 'Y' || $response =~ /^yes$/i) {
        $prompt = 1;
    }
    return $prompt;
}

sub promptForGlobalWildcard
{
    my ($wildcard) = @_;
    my $prompt = 0;
    print cwd(), '\\', $wildcard, ', Are you sure (Y/N)? ';
    $response = <STDIN>;
    if ($response eq 'y' || $response eq 'Y' || $response =~ /^yes$/i) {
        $prompt = 1;
    }
    return $prompt;
}

sub usage
{
    print <<EOF;
Deletes one or more files.

DEL [/P] [/F] [/S] [/Q] [/A[[:]attributes]] names
ERASE [/P] [/F] [/S] [/Q] [/A[[:]attributes]] names

  names         Specifies a list of one or more files or directories.
                Wildcards may be used to delete multiple files. If a
                directory is specified, all files within the directory
                will be deleted.

  /P            Prompts for confirmation before deleting each file.
  /F            Force deleting of read-only files.
  /S            Delete specified files from all subdirectories.
  /Q            Quiet mode, do not ask if ok to delete on global wildcard
  /A            Selects files to delete based on attributes
  attributes    R  Read-only files            S  System files
                H  Hidden files               A  Files ready for archiving
                -  Prefix meaning not

If Command Extensions are enabled DEL and ERASE change as follows:

The display semantics of the /S switch are reversed in that it shows
you only the files that are deleted, not the ones it could not find.

EOF
}

