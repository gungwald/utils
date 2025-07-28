#!/usr/bin/env perl

# Author:  Bill Chatfield
# License: GPL3

use strict;
use warnings;
use Net::GitHub; # Install perl-Net-GitHub in Fedora

# Read token from token file.
my $tokenFile = "$ENV{HOME}/Dropbox/.github/readonly-token.txt"; 
open(TOKEN, "<$tokenFile") || die "open $tokenFile: $!\n";
my $token = <TOKEN>;
chomp($token);
close(TOKEN);

my $github = new Net::GitHub(  # Net::GitHub::V3
	version => 3,
	access_token => $token,
	RaiseError => 1
);
           
my @repos = $github->repos->list();

foreach my $repo (@repos) {
	print $$repo{name}, "\n";
}
