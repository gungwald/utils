#!/usr/bin/env perl

use POSIX qw(asctime ctime gmtime localtime strftime);

print "ACTION DAY DATE       TIME   TZ  FILE\n";

for my $file (@ARGV) {
    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = stat($file);

    for my $ref (['Create',$ctime], ['Modify',$mtime], ['Access',$atime]) {
        my ($label, $time) = @$ref;
        my $localTime = strftime("%a %Y-%m-%d %l:%M%P %Z", localtime($time));
        printf("%s %s %s\n", $label, $localTime, $file);
    }
}


