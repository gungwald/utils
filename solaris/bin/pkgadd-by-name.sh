#!/bin/sh

findHighestVersion() {
  ls "$1"*.tgc-sunos5.7-sparc-tgcware | tail -1
}


