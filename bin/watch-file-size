#!/usr/bin/env perl

if ( @ARGV > 0 ) {
    # Turn on autoflush.
    $| = 1;

    print $ARGV[0], ": ";
    $size = "";
    while (1) {
        $oldSize = $size;

        (
            $dev,  $ino,   $mode,  $nlink, $uid,     $gid, $rdev,
            $size, $atime, $mtime, $ctime, $blksize, $blocks
        ) = stat($ARGV[0]);

        for ($i = 0; $i < length($oldSize); $i++) {
            print "\b";
        }
        print $size;
        sleep(1);
    }
}
