#!/usr/bin/perl

# Author: Bill Chatfield - https://github.com/gungwald

use strict;
use warnings FATAL => 'all';
use open ':std', ':encoding(UTF-8)';    # Makes STDIN, STDOUT, STDERR UTF-8 compatible
use Data::Dumper;
use Try::Tiny;
use Exception::Class ('ModuleInterfaceException');

use constant EXIT_SUCCESS => 0;
use constant EXIT_FAILURE => 1;

# Import Net::GitHub module or provide instructions for installing it.
# TODO - The same for Exception::Class - libexception-class-perl
# TODO - The same for Tiny::Try - libtiny-try-perl???
# TODO - Convert eval to try/catch
BEGIN {
    eval {use Net::GitHub::V3};
    if ($@) {
        say STDERR "Please install required modules via one of these options: ";
        say STDERR '';
        say STDERR "    Any System:";
        say STDERR "    (Recommended to get a working version of Net::GitHub)";
        say STDERR "    sudo cpan -i Try::Tiny Exception::Class Net::GitHub";
        say STDERR '';
        say STDERR "    Ubuntu, Debian, Mint:";
        say STDERR "    (Not recommended due to old and broken libnet-github-perl)";
        say STDERR "    sudo apt install libtry-tiny-perl libexception-class-perl libnet-github-perl";
        say STDERR '';
        say STDERR "    Fedora:";
        say STDERR "    sudo dnf install perl-Try-Tiny perl-Exception-Class perl-Net-GitHub";
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
