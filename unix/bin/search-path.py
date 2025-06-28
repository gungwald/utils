#!/usr/bin/env python

import glob
import os
import sys

for pattern in sys.argv[1:]:
    path = os.environ["PATH"]
    for dir in path.split(os.pathsep):
        if os.path.exists(dir):
            os.chdir(dir)
            for match in glob.glob("*" + pattern + "*"):
                print(os.path.join(dir, match))
