#!/usr/bin/env perl

# Attempts to fix the error: "could not do untrusted question as no klass
# support"
# Bill Chatfield - GPL2

# The problem is caused by repos that have GPG disabled, probably because
# their packages are unsigned. The gpgcheck=0 in repo file is the direct 
# cause of the error. But, you can't just set it to 1 because then any 
# packages will fail to upgrade because they're likely unsigned.

BEGIN {
	my $mod = qw(Config::INI::Reader);
	eval "use $mod";
	if ($@) {
		warn "Couldn\'t load module $mod: $@\n";
		my $iniPackage = "perl-Config-INI";
		my $isIniInstalled = (system("rpm --query --quiet $iniPackage") >> 8) == 0;
		if ($isIniInstalled) {
			warn "Don't know what to do because required package is already installed: $iniPackage\n";
			exit(1);
		} else {
		    print "Required package $iniPackage will be installed.\n";
		    system("sudo dnf -y install $iniPackage");
		}
	}
	$mod->import();
}

my @repoFiles=`grep -lw 'gpgcheck=0' /etc/yum.repos.d/*`;
my $foundRepoToDisable = 0;
for my $repoFile (@repoFiles) {
    chomp($repoFile);
    my $conf = Config::INI::Reader->read_file($repoFile);
    for my $repoName (keys(%$conf)) {
        my $repoProps = $conf->{$repoName};
        if ($repoProps->{gpgcheck} == 0 && $repoProps->{enabled} == 1) {
            $foundRepoToDisable = 1;
            print "The $repoName repo has gpgcheck turned off, so it will be disabled.\n";
            system("sudo dnf config-manager --set-disabled $repoName");
        }
    }
}

if (! $foundRepoToDisable) {
    print "All repos are ready for upgrade.\n";
}

