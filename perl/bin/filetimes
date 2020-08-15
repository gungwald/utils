#!/usr/bin/env perl

use POSIX qw(asctime ctime gmtime localtime strftime);

for my $file (@ARGV) {
        my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = stat($file);

        if (! $ENV{TZ}) {
                # If the time zone is not set, assume it is Eastern Time.
                $ENV{TZ} = 'America/New_York';
        }

        print "\n";

        for my $ref (['Create',$ctime], ['Modify',$mtime], ['Access',$atime]) {
                my ($label, $time) = @$ref;
                printf("$label time = %s\n", strftime("%A %e-%b-%Y %l:%M%P UTC (Greenwich Mean Time)", gmtime($time)));
                printf("$label time = %s\n", strftime("%A %e-%b-%Y %l:%M%P %Z (local time)\n", localtime($time)));
        }

}


