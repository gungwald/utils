#!/bin/sh

# Don't use directories with spaces in them or you'll have to put double-quotes
# around all your variable references.

# Exit when an error occurs.
set -e

NAME=m2c-0.7
ALL_SRC=$HOME/src
SRC=$ALL_SRC/$NAME
BUILD_DIR=$SRC-build
INSTALL_PREFIX=/opt/gnu/m2c
CC=egcc
REMOTE_URL='https://mirror.cedia.org.ec/nongnu/m2c/0.7/$NAME.tar.gz'
DOWNLOADED_ARCHIVE="$HOME/Downloads/$NAME.tar.gz"

if [ `uname -s` = 'OpenBSD' ]
then
  ESCALATE_PRIVILEGES=doas
else
  ESCALATE_PRIVILEGES=sudo
fi

# Download tar
if [ ! -f "$DOWNLOADED_ARCHIVE" ]
then
  curl -o "$DOWNLOADED_ARCHIVE" "$REMOTE_URL"
fi

# Unzip
if [ ! -f "$SRC/$NAME/configure" ]
then
  cd $ALL_SRC
  tar -xvzf "$DOWNLOADED_ARCHIVE"
fi

# Build
cd $SRC
./configure +cc=$CC +srcdir=$SRC

mkdir -p $BUILD_DIR
cd $BUILD_DIR
make CC=$CC prefix=$INSTALL_PREFIX
$ESCALATE_PRIVILEGES make install CC=$CC prefix=$INSTALL_PREFIX
