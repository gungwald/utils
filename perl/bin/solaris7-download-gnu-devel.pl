#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;
use File::Path qw(make_path);

my $baseUrl = 'https://jupiterrise.com/tgcware/sunos5.7_sparc/stable/';
my $destDir = $ENV{HOME} . '/Dropbox/storage/solaris7';
make_path($destDir);
$_ = get($baseUrl);
my @fileNames = / href="(.*?)"/gm;
for (@fileNames) {
    if (/\.gz$/) {
        my $url = $baseUrl . $_;
	my $destFile = $destDir . '/' . $_;
	print "Downloading $destFile\n";
        getstore($url, $destFile);
    }
}
