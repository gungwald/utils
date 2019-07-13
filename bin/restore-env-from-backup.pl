# Restores all environment variables stored in a file which were
# exported like this: set > filename
#
# The variables are stored permanently as system environment variables.
# Any matching variables are overwritten. None are deleted.
#
# Use CPAN to install the non-standard module: cpan> install Win32::Env
#
# Author:   Bill Chatfield <bill.chatfield@cardinalhealth.com>
# Created:  October 10, 2014
#
use Win32::Env;

# Permanently sets a system environment variable.
sub set_system_var($)
{
    my ($key, $value) = split(/=/, @_[0]);
    print "Setting $key=$value\n";
    #SetEnv(ENV_SYSTEM, $key, $value);
}

sub backup_system_vars
{
    my @sys_vars = ListEnv(Win32::Env::ENV_SYSTEM);
    open(BKUP, ">system.vars.backup.$$.txt") || die "Failed to create backup file: $!\n"; 
    for $var (@sys_vars) {
        print BKUP "$var\n";
    }
    close(BKUP);
}

backup_system_vars();

if (@ARGV > 0) {
    # Read command line arguments
    for $f (@ARGV) {
        if ($f eq '-') {
            # Read stdin
            while (<>) {
                chomp;
                set_system_var($_);
            }
        }
        if (open(VARS, $f)) {
            while (<VARS>) {
                chomp;
                set_system_var($_);
            }
            close(VARS)
        }
        else {
            print STDERR "$f: $!\n";
        }
    }
}
else {
    print STDERR "No input files.\n";
}
