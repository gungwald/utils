
format STDOUT_TOP = 
 *****  ***********************************************************************
  PID                                COMMAND
 *****  ***********************************************************************
.
# END OF FORMAT

format STDOUT =
 @####  ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 $pid,  $cmd
~~          ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            $cmd

.
# END OF FORMAT

$= = 24;    # Lines per page (screen)
$^L = '';   # Form feed character

open(WMIC, "wmic process get commandline,processid | ") || die "$!\n";

while (<WMIC>) {
    s/ //g;
    ($cmd, $pid) = /^\s*(.+?)\s*(\d+)\s*$/;
    write;
}

close(WMIC);

