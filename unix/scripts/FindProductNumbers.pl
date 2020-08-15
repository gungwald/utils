#!/usr/bin/perl

foreach $arg (@ARGV) {
    open(IN, $arg) || die "$arg: $!\n";
    while (<IN>) {
        ($productNumber) = /<productNumber>(.*)<\/productNumber>/;
        if ($productNumber) {
            print "'M$productNumber', ";
        }
    }
    close(IN);
}