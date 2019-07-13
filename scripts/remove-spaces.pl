foreach $file (@ARGV)
{
    open(FILE, $file) || die "$file: $!\n";
    while (<FILE>)
    {
        s/ |\xA0//g;
        print $_;
    }
    close(FILE);
}

