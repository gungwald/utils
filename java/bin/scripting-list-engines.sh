#!/bin/sh
libDir=$HOME/git/utils/java/lib
java -cp $libDir/bsf-all-3.1.jar:$libDir/sleep.jar:$libDir/bsh-2.0b6.jar:$libDir/jython-standalone-2.7.0.jar:$libDir/js.jar org.apache.bsf.Main -show factories
