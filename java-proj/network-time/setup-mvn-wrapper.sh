#!/bin/sh

# This is the last version of Maven supporting Java 7. This is the minimum
# Java version required by the code. This allows the code to be compiled by
# any Java version from 7 to the current version. This is the most versatile
# solution. If a higher version was used, then people using lower
# versions would be forced to reconfigure their development environment
# to use that higher version, potentially breaking their support of
# lower Java versions. Not all operating systems support the latest Java
# version, so it's not correct to assume one can require the latest version.
MAVEN_VERSION=3.8.9
mvn wrapper:wrapper -Dmaven="$MAVEN_VERSION"