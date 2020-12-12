#!/bin/sh

cd $HOME/git/jamvm
./autogen.sh --with-java-runtime-library=openjdk8

make
