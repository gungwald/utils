#!/usr/bin/python

"""
The problem with doing this in Python is that it's not backwards compatible.
A Python 2 program won't run on Python 3. Java, Shell, C, PCs are all
backwards compatible. It's a necessary feature. The latest Fedora
has Python 3 whereas Mac OS 10.4 has Python 2. There's no way
to write one script for both. So you can't create one program and have it
run everywhere.
"""

from platform import uname
import csv


def read_os_release():
    my_os_release = {}
    with open("/etc/os-release") as f:
        reader = csv.reader(f, delimiter="=")
        for row in reader:
            if row:
                my_os_release[row[0]] = row[1]
    return my_os_release


os_name = uname().system
if os_name == "Linux":
    os_release = read_os_release()
    print(os_release["PRETTY_NAME"])
    if os_release["ID"] == "ubuntu":
        print("ubuntu")
