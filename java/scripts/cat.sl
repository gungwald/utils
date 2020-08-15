foreach $file (@ARGV) {
    $f = openf($file);
    while $line (readln($f)) {
        println($line);
    }
    closef($f);
}

