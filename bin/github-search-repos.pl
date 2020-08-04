#!/usr/bin/perl

# Bill Chatfield <bill_chatfield@yahoo.com>

# This program requires Perl's Net::GitHub package which is not installed by
# default on most systems.

use strict;
use warnings FATAL => 'all';

use constant EXIT_SUCCESS => 0;
use constant EXIT_FAILURE => 1;

# Import GitHub module or provide instructions for installing it.
BEGIN {
    eval {use Net::GitHub};
    if ($@) {
        say STDERR "Required Perl module Net::GitHub is not installed: $@";
        if (-f "/etc/os-release") {
            my ($os, $osLike) = `. /etc/os-release && echo \$ID && echo \$ID_LIKE`;
            if ($os =~ /fedora/) {
                say STDERR "Install it with this command: sudo dnf install perl-Net::GitHub";
            }
            elsif ($os =~ /redhat/) {
                say STDERR "Install it with this command: sudo yum install perl-Net::GitHub";
            }
            elsif ($os =~ /debian/ || $osLike =~ /debian/) {
                say STDERR "Install it with this command: sudo apt install libnet-github-perl";
            }
        }
        else {
            say STDERR "Install it with this command: sudo cpan -i Net::GitHub";
        }
        exit(EXIT_FAILURE);
    }
}

if (@ARGV == 0) {
    print "Please provide a search string.\n";
    exit(EXIT_SUCCESS);
}

my $github = new Net::GitHub(version => 3, RaiseError => 1);
my $ghSearch = $github->search;
my $searchCriteria = join(' ', @ARGV);
my %searchResults = $ghSearch->repositories({ q => $searchCriteria, sort => 'stars', });
my $repos = $searchResults{items};

foreach my $repo (@$repos) {
    print $$repo{name}, "\n";
    print $$repo{description}, "\n";
    print "\n";
}

