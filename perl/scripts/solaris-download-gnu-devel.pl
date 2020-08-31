#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;
use File::Path qw(make_path);

my $version = "";
while ($version ne "7" && $version ne "8") {
    print "Select a version of Solaris\n";
    print "7 - for Solaris 7\n";
    print "8 - for Solaris 8\n";
    print "Version: ";
    $version = <STDIN>;
    chomp($version);
}

my $baseUrl = "https://jupiterrise.com/tgcware/sunos5." . $version . "_sparc/stable/";
my $destDir = $ENV{HOME} . "/Dropbox/installers/solaris/$version/tgcware";

make_path($destDir);
my $html = get($baseUrl);
my @fileNames = ($html =~ / href="(.*?)"/gm);
for (@fileNames) {
    if (/\.gz$/) {
        my $url = $baseUrl . $_;
	my $destFile = $destDir . '/' . $_;
	print "Downloading $destFile\n";
        getstore($url, $destFile);
    }
}
