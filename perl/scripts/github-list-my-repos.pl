#!/usr/bin/perl

# Bill Chatfield <bill_chatfield@yahoo.com>

use strict;
use warnings;
use Net::GitHub; # Install perl-Net-GitHub in Fedora

my $github = Net::GitHub->new(  # Net::GitHub::V3
	version => 3,
	access_token => 'dc77a8e3ede6e64f378c5c7f08d06b3d65602f68',
	RaiseError => 1
);
           
my @repos = $github->repos->list();

foreach my $repo (@repos) {
	print $$repo{name}, "\n";
}
