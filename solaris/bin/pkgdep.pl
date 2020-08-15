#!/usr/bin/env perl

for $pkg (@ARGV) {
  open(PKGADD_OUTPUT, "-|", "echo all | pkgadd -d $pkg 2>&1") || die "$!\n";
  while (<PKGADD_OUTPUT>) {
    my ($depId, $depName, $depDesc) = /The <(.*?)> package "(.*?) - (.*)/;
    if ($depId) {
      print "$depId - $depName\n";
    }
  }
  close(PKGADD_OUTPUT);
}
