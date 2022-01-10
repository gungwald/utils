#!/bin/sh
INSTALL_DIR="$HOME"/bin
INSTALL_FILE="$INSTALL_DIR"/dropbox
mkdir -p "$INSTALL_DIR"
wget --output-document="$INSTALL_FILE" "https://www.dropbox.com/download?dl=packages/dropbox.py"
chmod a+x "$INSTALL_FILE"
cd "$HOME"
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
.dropbox-dist/dropboxd

# The above starts a process will will ask you to go to a url that has a long
# random string. You can't do it with lynx because dropbox.com requires
# JavaScript and only supports new browsers.
# I tried to set up gpm to copy and paste it but gpm won't work.
# Only option is to manually type the url on another computer.

# TODO - Setup auto-start - use some kind of daemonify utility - find one
# TODO - Set the sysctl value or whatever it is to unlimit the number of open files
