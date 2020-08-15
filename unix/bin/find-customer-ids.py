#!/usr/bin/python

import sys
import re

pattern = re.compile(r"<customerId>(.*)</customerId>")
timestampPattern = re.compile(r"^(.*?M) ")

sql = ""
previousLine = ""
for arg in sys.argv[1:]:
    with open(arg) as f:
        for line in f:
            matched = pattern.search(line)
            if matched:
                sql += "'M%s', " % matched.group(1)
                print "%s  %s" % (timestampPattern.search(previousLine).group(1), matched.group(1))
            previousLine = line

print "(", sql.rstrip().rstrip(","), ")"

