#!/usr/bin/env perl

# Author: Bill Chatfield - https://github.com/gungwald

use strict;
use Data::Dumper;

use constant EXIT_SUCCESS => 0;
use constant EXIT_FAILURE => 1;

# Import non-standard modules or provide instructions for installing them.
BEGIN {
    my $isModuleMissing = 0;
    # Simply checking the return value of eval doesn't work in old versions
    # of Perl. The $@ variable must be checked.
    # Make STDIN, STDOUT, STDERR UTF-8 compatible
    eval "use open ':std', ':encoding(UTF-8)'";
    if ($@) {
        #print STDERR $@;
        print STDERR "Please install Perl module 'open'\n";
        print STDERR "    Fedora: sudo dnf install perl-open\n";
        print STDERR "    Debian: it should be installed by default\n";
        print STDERR "    CPAN:   sudo cpan -i open\n";
        $isModuleMissing = 1;
    }
    eval "use Net::GitHub::V3";
    if ($@) {
        #print STDERR $@;
        print STDERR "Please install Perl module Net::GitHub\n";
        print STDERR "    Fedora: sudo dnf install perl-Net-GitHub\n";
        print STDERR "    Debian: sudo apt install libnet-github-perl\n";
        print STDERR "    CPAN:   sudo cpan -i Net::GitHub\n";
        $isModuleMissing = 1;
    }
    eval "use Try::Tiny";
    if ($@) {
        #print STDERR $@;
        print STDERR "Please install Perl module Try::Tiny\n";
        print STDERR "    Fedora: sudo dnf install perl-Try-Tiny\n";
        print STDERR "    Debian: sudo apt install libtry-tiny-perl\n";
        print STDERR "    CPAN:   sudo cpan -i Try::Tiny\n";
        $isModuleMissing = 1;
    }
    eval "use Exception::Class ('ModuleInterfaceException')";
    if ($@) {
        #print STDERR $@;
        print STDERR "Please install Perl module Exception::Class\n";
        print STDERR "    Fedora: sudo dnf install perl-Exception-Class\n";
        print STDERR "    Debian: sudo apt install libexception-class-perl\n";
        print STDERR "    CPAN:   sudo cpan -i Exception::Class\n";
        $isModuleMissing = 1;
    }
    if ($isModuleMissing) {
        exit(EXIT_FAILURE);
    }
}

my $count = 0;
sub printRepos($)
{
    my ($repos) = @_;
    foreach my $repo (@$repos) {
        $count++;
        print $count, '. ', $$repo{url}, "\n";
        if (defined($$repo{description})) {
            print $$repo{description}, "\n";
        }
        else {
            print "(No description)\n";
        }
        print "\n";
    }
}

if (@ARGV == 0) {
    print "Please provide a search string.\n";
    exit(EXIT_SUCCESS);
}

my $github = new Net::GitHub::V3(RaiseError => 1);
my $ghSearch = $github->search;
my $searchCriteria = join(' ', @ARGV);
my $searchRequest = { q => $searchCriteria, sort => 'stars' };

printRepos($ghSearch->repositories($searchRequest)->{items});
while ($ghSearch->has_next_page) {
    printRepos($ghSearch->next_page->{items});
}
