#!/bin/sh

# If the version numbers are not in sync, the JRE/JDK get stuck at 275
# and jamvm cannot be installed.

#OPENJDK_VERSION=8u131-b11-2ubuntu1.16.04.3
OPENJDK_VERSION=8u275-b01-0ubuntu1~16.04
#OPENJDK_VERSION=8u77-b03-3ubuntu3

sudo apt install -V \
	openjdk-8-jre-headless="$OPENJDK_VERSION"	\
	openjdk-8-jre-jamvm="$OPENJDK_VERSION"		\
	openjdk-8-jdk-headless="$OPENJDK_VERSION"	\
	openjdk-8-jdk="$OPENJDK_VERSION"		\
	openjdk-8-jre="$OPENJDK_VERSION"
