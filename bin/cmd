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

use File::Basename; # for dirname
use Term::ReadLine;
use English '-no_match_vars'; # for things like $ERRNO instead of $!.

# Global variables
$echo = 1; # on by default
$systemInitScript = '/etc/autoexec.bat';
$userInitScript = $ENV{'HOME'} . '.autoexec.bat';
$optUserInitScript = $ENV{'HOME'} . 'autoexec.bat';
$osName = `uname`;
$osVersion = `uname -r`;
chop($osName);              # Remove newline
chop($osVersion);           # Remove newline

# Set default environment variables
$ENV{'PATHEXT'} = '.BAT;.CMD';

fileparse_set_fstype("MSWin32");

print "$osName [Version $osVersion]\n";
print "Command Prompt [Version 1.0]\n";
print "(C) Copyright 2002 Bill Chatfield\n";

# Perform initialization scripts
if ($PROGRAM_NAME =~ /^-/) {    # If cmd starts with -, it is a login shell
    performLoginInitialization();
}

while ($arg = shift) {
    if ($arg =~ /\/c/i) {
        processLine(shift);
        exit(0);
    }
    if ($arg =~ /\/l/i) {
        performLoginInitialization();
    }
}

$term = new Term::ReadLine 'Command Prompt';
print "\n";
while (defined($line = $term->readline(getPrompt())))
{
    processLine($line);
    print "\n";
}

sub performLoginInitialization
{
    if (-f $systemInitScript) {
        runBatchFile($systemInitScript);
    }
    if (-f $optUserInitScript) {
        runBatchFile($optUserInitScript);
    } elsif (-f $userInitScript) {
        runBatchFile($userInitScript);
    }
}

sub runBatchFile
{
    my $fileName = shift;
    my $fullName = findBatchFile($fileName);
    my $echoThisCommand = 0;
    my $line;
    if (defined(open(BATCH, $fullName)))
    {
        while ($line = <BATCH>)
        {
            if ($line =~ /^@/) {
                $echoThisCommand = 0;
                ($line) = ($line =~ /^@(.*)$/);
            } else {
                $echoThisCommand = 1;
            }
            if ($echo && $echoThisCommand) {  # Semantic not quite right
                print getPrompt(), $line;
            }
            processLine($line);
        }
        close(BATCH);
    }
    else
    {
        print STDERR $fullName, ': ', $ERRNO;
    }
}

sub findBatchFile
{
    my $fileName = shift;
    if (-f $fileName)
    {
        return $fileName;
    }
    my @paths = split(/:/, $ENV{'PATH'});
    unshift(@paths, '.');
    foreach $path (@paths)
    {
        my $fullName = $path . '/' . $fileName;
        if (-f $fullName)
        {
            return $fullName;
        }
    }
    return $fileName;
}

sub processLine
{
    my ($line) = @_;
    my @cmds = split(/\|/, $line);
    my $cmd = shift(@cmds);
    my $realStdoutHandle = *STDOUT;
    if (@cmds > 0)
    {
        my $theRest = join('|', @cmds);
        print STDERR $theRest, "\n";
        if (open(PIPE, "| $0 /c $theRest"))
        {
            print STDERR "stdout = ", fileno(STDOUT), " pipe = ", fileno(PIPE), "\n";
            *STDOUT = *PIPE;
            print STDERR "stdout = ", fileno(STDOUT), " pipe = ", fileno(PIPE), "\n";
            processCmd($cmd);
            *STDOUT = $realStdoutHandle;
            close(PIPE);
        }
        else
        {
            print STDERR "Failed to open pipe: $!", "\n";
        }
    }
    else
    {
        processCmd($cmd);
    }

}

sub processCmd
{
    my ($line) = @_;
    my $line = replaceVariables($line);
    my @params = ($line =~ /((?:[^"\s]|".*")+)/g);
    my $errorLevel = runCommand($line, @params);
    if ($params[0] ne '')
    {
        if ($errorLevel == -1)
        {
            my $pid = fork;
            if ($pid == 0)
            {
                $params[0] =~ s/\\/\//g; # Make 1st arg UNIX style so exec works.
                my $oldPath = $ENV{'PATH'};
                $ENV{'PATH'} = '.:' . $oldPath;
                exec @params;
                $ENV{'PATH'} = $oldPath;
                print "'", $params[0], "' is not recognized as an ",
                    "internal or external command,\n",
                    "operable program, or batch file.\n";
                exit 1;
            }
            elsif (defined($pid))
            {
                wait;
            }
            else
            {
                print STDERR $ERRNO;
            }
        }
    }
}

sub getPrompt
{
    $cwd = `pwd`;
    chop($cwd);
    $cwd =~ s/\//\\/g;
    return "C:$cwd>";
}

sub replaceVariables
{
    my ($line) = @_;
    while (($match) = ($line =~ m/%(\w+?)%/))
    {
        $value = $ENV{$match};
        if (defined($value))
        {
            $line =~ s/%\w+?%/$value/;
        }
    }
    return $line;
}

sub runCommand
{
    my ($line, $cmd, @args) = @_;
    my $result = -1;

    if ($cmd =~ /^exit$/i)
    {
        $result = 0;
        exit;
    }
    elsif ($cmd =~ /^if$/i)
    {
    }
    elsif ($cmd =~ /^rem$/i)
    {
        $result = 0;
    }
    elsif ($cmd =~ /^rename$/i || $cmd =~ /^ren$/i)
    {
        $origName = @args[0];
        $newName = @args[1];
        $dirName = dirname(@args[0]);
        if (rename($origName, $dirName . '\\' . $newName))
        {
            $result = 0;
        }
        else
        {
            print STDERR "$origName: $!\n";
            $result = 1;
        }
    }
    elsif ($cmd =~ /^ver$/i)
    {
        $result = 0;
        print "\n$osName [Version $osVersion]\n";
    }
    elsif ($cmd =~ /^path$/i)
    {
        print "PATH=", $ENV{'PATH'};
        $result = 0;
    }
    elsif ($cmd =~ /^cd$/i)
    {
        $dir = $args[0];
        $dir =~ s/\\/\//g;
        if (chdir $dir)
        {
            $result = 0;
        }
        else
        {
            $result = 1;
        }
    }
    elsif ($cmd =~ /^set$/i)
    {
        $result = doSet(@args);
    }
    elsif ($cmd =~ /^type$/i)
    {
        $result = doType(@args);
    }
    elsif ($cmd =~ /^echo$/i)
    {
        ($rest) = ($line =~ /^echo (.*)$/i);
        if ($rest =~ /^ *on *$/i) {
            $echo = 1;
        } elsif ($rest =~ /^ *off *$/i) {
            $echo = 0;
        } else {
            print $rest, "\n";
        }
        $result = 0;
    }
    elsif ($line =~ /^echo\./)
    {
        ($rest) = ($line =~ /echo\.(.*)$/);
        print $rest, "\n";
        $result = 0;
    }
    elsif ($cmd =~ /^cls$/i)
    {
        system('clear');
        $result = 0;
    }
    elsif ($cmd =~ /^help$/i)
    {
        doHelp();
        $result = 0;
    }
    elsif ($cmd =~ /\.bat$/i)
    {
        runBatchFile($cmd, @args);
        $result = 0;
    }
    elsif ($cmd =~ /^mkdir$/i || $cmd =~ /^md$/i)
    {
        $result = doMkdir(@args);
    }
    elsif ($cmd =~ /^rmdir$/i || $cmd =~ /^rd$/i)
    {
        $result = doRmdir(@args);
    }
    else
    {
        # Add .bat extension and check for matches in the PATH.
        my @dirs = split(/:/, $ENV{'PATH'});    # Put PATH into array
        my @exts = split(/;/, $ENV{'PATHEXT'}); # Put PATHEXT into array
        unshift(@dirs, '.');                    # Assume current dir
        foreach $dir (@dirs) {                  # Iterate over PATH elements
            foreach $ext (@exts) {
                $ext = uc($ext);                # Not right, implement exists
                my $file = $dir . '/' . $cmd . $ext;
                if (-f $file) {
                    runBatchFile($file);
                } else {
                    $ext = lc($ext);
                    $file = $dir . '/' . $cmd . $ext;
                    if (-f $file) {
                        runBatchFile($file);
                    }
                }
            }
        }
    }
        
    return $result;
}

sub doSet
{
    if (@_ == 0)
    {
        foreach $key (keys(%ENV))
        {
            print $key, '=', $ENV{$key}, "\n";
        }
    }
    else
    {
        ($name, $value) = (@_[0] =~ /(\w+?)=(\w*)/);
        if ($value eq '')
        {
            delete $ENV{$name};
        }
        else
        {
            $ENV{$name} = $value;
        }
    }
    return 0;
}

sub doType
{
    my ($fileName) = @_;
    if (open(FILE, $fileName))
    {
        while (<FILE>)
        {
            print $_;
        }
        close(FILE);
    }
    else
    {
        print STDERR $!, "\n";
        $result = 1;
    }
    return $result;
}

sub doHelp
{
    print <<EOF;
For more information on a specific command, type HELP command-name
ASSOC    Displays or modifies file extension associations.
AT       Schedules commands and programs to run on a computer.
ATTRIB   Displays or changes file attributes.
BREAK    Sets or clears extended CTRL+C checking.
CACLS    Displays or modifies access control lists (ACLs) of files.
CALL     Calls one batch program from another.
CD       Displays the name of or changes the current directory.
CHCP     Displays or sets the active code page number.
CHDIR    Displays the name of or changes the current directory.
CHKDSK   Checks a disk and displays a status report.
CHKNTFS  Displays or modifies the checking of disk at boot time.
CLS      Clears the screen.
CMD      Starts a new instance of the Windows command interpreter.
COLOR    Sets the default console foreground and background colors.
COMP     Compares the contents of two files or sets of files.
COMPACT  Displays or alters the compression of files on NTFS partitions.
CONVERT  Converts FAT volumes to NTFS.  You cannot convert the
         current drive.
COPY     Copies one or more files to another location.
DATE     Displays or sets the date.
DEL      Deletes one or more files.
DIR      Displays a list of files and subdirectories in a directory.
DISKCOMP Compares the contents of two floppy disks.
DISKCOPY Copies the contents of one floppy disk to another.
DOSKEY   Edits command lines, recalls Windows commands, and creates macros.
ECHO     Displays messages, or turns command echoing on or off.
ENDLOCAL Ends localization of environment changes in a batch file.
ERASE    Deletes one or more files.
EXIT     Quits the CMD.EXE program (command interpreter).
FC       Compares two files or sets of files, and displays the differences
         between them.
FIND     Searches for a text string in a file or files.
FINDSTR  Searches for strings in files.
FOR      Runs a specified command for each file in a set of files.
FORMAT   Formats a disk for use with Windows.
FTYPE    Displays or modifies file types used in file extension associations.
GOTO     Directs the Windows command interpreter to a labeled line in a
         batch program.
GRAFTABL Enables Windows to display an extended character set in graphics
         mode.
HELP     Provides Help information for Windows commands.
IF       Performs conditional processing in batch programs.
LABEL    Creates, changes, or deletes the volume label of a disk.
MD       Creates a directory.
MKDIR    Creates a directory.
MODE     Configures a system device.
MORE     Displays output one screen at a time.
MOVE     Moves one or more files from one directory to another directory.
PATH     Displays or sets a search path for executable files.
PAUSE    Suspends processing of a batch file and displays a message.
POPD     Restores the previous value of the current directory saved by PUSHD.
PRINT    Prints a text file.
PROMPT   Changes the Windows command prompt.
PUSHD    Saves the current directory then changes it.
RD       Removes a directory.
RECOVER  Recovers readable information from a bad or defective disk.
REM      Records comments (remarks) in batch files or CONFIG.SYS.
REN      Renames a file or files.
RENAME   Renames a file or files.
REPLACE  Replaces files.
RMDIR    Removes a directory.
SET      Displays, sets, or removes Windows environment variables.
SETLOCAL Begins localization of environment changes in a batch file.
SHIFT    Shifts the position of replaceable parameters in batch files.
SORT     Sorts input.
START    Starts a separate window to run a specified program or command.
SUBST    Associates a path with a drive letter.
TIME     Displays or sets the system time.
TITLE    Sets the window title for a CMD.EXE session.
TREE     Graphically displays the directory structure of a drive or path.
TYPE     Displays the contents of a text file.
VER      Displays the Windows version.
VERIFY   Tells Windows whether to verify that your files are written
         correctly to a disk.
VOL      Displays a disk volume label and serial number.
XCOPY    Copies files and directory trees.
EOF
}

# TODO:
# 1. Implement extended functionality
# 2. Implement correct error messages

sub doMkdir
{
    my $dirName = shift(@_);
    my $result = 0;
    my $unixDirName = $dirName;
    $unixDirName =~ s/\\/\//g;
    if (!mkdir($unixDirName)) {
        print STDERR "$dirName: $ERRNO\n";
        $result = 1;
    }
    return $result;
}

sub doRmdir
{
    my $quiet = 0;
    my $subdirectories = 0;
    my $directory = undef;
    foreach $arg (@_) {
        if ($arg =~ /\/s/i) {
            $subdirectories = 1;
        }
        if ($arg =~ /\/q/i) {
            $quite = 1;
        }
        if (!defined($directory)) {
            ($directory) = ($arg =~ /^(.*?)\//);
            if (!defined($directory)) {
                $director = $arg;
            }
        }
        
    }
}

