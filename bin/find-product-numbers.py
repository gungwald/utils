#!/usr/bin/python

import sys
import re

pattern = re.compile(r"<productNumber>(.*)</productNumber>")

sql = ""
for arg in sys.argv[1:]:
    with open(arg) as f:
        for line in f:
            matched = pattern.search(line)
            if matched:
                sql += "'M%s', " % matched.group(1)
		print matched.group(1)

print "(", sql.rstrip().rstrip(","), ")"

