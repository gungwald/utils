#!/bin/sh

# Don't use directories with spaces in them or you'll have to put double-quotes
# around all your variable references.

# Exit when an error occurs. Can't do this because we're checking for grep failures.

NAME=m2c-0.7
ALL_SRC="$HOME"/src
SRC="$ALL_SRC"/"$NAME"
BUILD_DIR="$SRC"-build
MAKE_TMPL="$SRC"/Makefile.tmpl
CONF_DIR="$SRC"/config
INSTALL_PREFIX=/opt/gnu
CC=egcc
REMOTE_URL='https://mirror.cedia.org.ec/nongnu/m2c/0.7/$NAME.tar.gz'
DOWNLOADED_ARCHIVE="$HOME/Downloads/$NAME.tar.gz"

if [ "$1" = 'clean' ]
then
  rm -rf "$SRC" "$BUILD_DIR"
  exit
fi

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
if [ ! -f "$SRC/configure" ]
then
  cd "$ALL_SRC"
  tar -xvzf "$DOWNLOADED_ARCHIVE"
fi

# Corrections to base distribution:
# Prepend source directory prefix to m2lib.h.
if grep ' m2lib.h' "$MAKE_TMPL" > /dev/null
then
  sed -i 's/ m2lib.h/ $(srcdir)\/m2lib.h/g' "$MAKE_TMPL"
fi

# Change all mkdir instances to mkdir -p
grep 'mkdir -p' "$MAKE_TMPL" > /dev/null
if [ $? -ne 0 ]
then
  sed -i 's/mkdir/mkdir -p/' "$MAKE_TMPL"
fi

# includedir dependency
grep '\$(includedir)\\' "$MAKE_TMPL" > /dev/null
if [ $? -ne 0 ]
then
  sed -i 's/^\(install:.*\)\\$/\1 $(includedir)\\/' "$MAKE_TMPL"
fi

# includedir rule
grep '^includedir:' "$MAKE_TMPL" > /dev/null
if [ $? -ne 0 ]
then
  PGM=`basename $0`
  INSTALL_DIR_RULE=`mktemp -t "$PGM".XXXXXXXXXX.txt` || exit
  cat >"$INSTALL_DIR_RULE" <<EOF

\$(includedir):
	mkdir -p \$(includedir)
EOF
  sed -i '/	\s*mkdir.*\$(man1dir)/r '$INSTALL_DIR_RULE "$MAKE_TMPL"
  rm "$INSTALL_DIR_RULE"
fi

# Setup config
if [ `uname -s` = 'OpenBSD' ]
then
  if [ ! -f "$CONF_DIR/$CC.h" ] || [ ! -f "$CONF_DIR/generic-$CC.h" ]
  then
    # Create config files defining egcc compiler for OpenBSD.
    sed "s/gcc/$CC/" "$CONF_DIR"/gcc.h > "$CONF_DIR"/"$CC".h
    sed "s/gcc\.h/$CC\.h/" "$CONF_DIR"/generic-gcc.h > "$CONF_DIR"/generic-"$CC".h
  fi
fi

# Everything below needs this regardless of if statements.
mkdir -p "$BUILD_DIR" || exit
cd "$BUILD_DIR"

# Configure
if [ ! -f "$BUILD_DIR/Makefile" ]
then
  # Setting the compiler here doesn't work, but it will stop for input if it is
  # not specified.
  $SRC/configure +cc="$CC" +srcdir="$SRC"
fi

# Build
make CC="$CC" prefix="$INSTALL_PREFIX"

# Install
"$ESCALATE_PRIVILEGES" make CC="$CC" prefix="$INSTALL_PREFIX" install

