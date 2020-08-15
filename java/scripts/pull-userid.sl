#
# Extracts userid from first column of CSV.
#
foreach $arg (@ARGV) {
	$f = openf($arg);
	if ($f) {
		while $line (readln($f)) {
			if ($line hasmatch '^"(.*?)"') {
				($userid) = matched();
				println($userid);
			}
			else {
				println("Line failed to match: $line");
			}
		}
		closef($f);
	}
	else {
		exit("Failed to open file: $arg: $error");
	}
}
