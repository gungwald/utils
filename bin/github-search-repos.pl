#!/usr/bin/perl

# Bill Chatfield <bill_chatfield@yahoo.com>

use Net::GitHub;

if (@ARGV == 0) {
	print "Please provide a search string.\n";
	exit(0);
}

my $github = Net::GitHub->new(
	version => 3,
	RaiseError => 1
);
           
my $ghSearch = $github->search;
my $searchCriteria = join(' ', @ARGV);

my %searchResults = $ghSearch->repositories({
	q => $searchCriteria,
	sort  => 'stars',
});

my $items = %searchResults{items};
foreach my $item (@$items) {
	print $$item{name}, "\n";
	print $$item{description}, "\n";
	print "\n";
}

