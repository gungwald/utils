#!/usr/bin/env perl

# Author: Bill Chatfield - https://github.com/gungwald

use strict;
use open ':std', ':encoding(UTF-8)'; # Makes STDIN, STDOUT, STDERR UTF-8 compatible
use Data::Dumper;

use constant EXIT_SUCCESS => 0;
use constant EXIT_FAILURE => 1;

# Import non-standard modules or provide instructions for installing them.
BEGIN {
    my $isModuleMissing = 0;
    if (! eval "use Net::GitHub::V3") {
        say STDERR "Please install module: sudo cpan -i Net::GitHub";
        $isModuleMissing = 1;
    }
    if (! eval "use Try::Tiny") {
        say STDERR "Please install module: sudo cpan -i Try::Tiny";
        $isModuleMissing = 1;
    }
    if (! eval "use Exception::Class ('ModuleInterfaceException')") {
        say STDERR "Please install module: sudo cpan -i Exception::Class";
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
