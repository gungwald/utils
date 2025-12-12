#!/usr/bin/perl -w

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

use warnings FATAL => 'all';
use strict;

# On Fedora perl-English is/was not installed by default. They claim to be
# trying to fix it, but I have an up-to-date system where it is not installed.
BEGIN {
    my $mod = qw(English);
    eval "use $mod";
    if ($@) {
        warn "Couldn\'t load module $mod: $@\n";
        my $iniPackage = "perl-Config-INI";
        my $isIniInstalled = (system("rpm --query --quiet $iniPackage") >> 8) == 0;
        if ($isIniInstalled) {
            die("Don't know what to do because required package is already installed: $iniPackage\n");
        } else {
            print "Required package $iniPackage will be installed.\n";
            system("sudo dnf -y install $iniPackage");
        }
    }
    $mod->import('-no_match_vars');
}

my $title = $ARGV[0];
my $exitValue = 0;

if ($OSNAME eq 'cygwin' || $OSNAME eq 'MSWin32') {
    my @cmdArgs = ('cmd', '/c', 'title', $title);
    $exitValue = system(@cmdArgs);
    if ($exitValue != 0) {
        print STDERR '"', join(' ', @cmdArgs), '" failed: ', $?, "\n";
    }
} else {
    # Send ESC ] 1 ; $1 BELL to xterm to set the icon label.
    print "\033]1;$title\007";

    # Send ESC ] 2 ; $1 BELL to xterm to set the title bar text.
    print "\0033]2;$title\0007";
}
exit($exitValue);

