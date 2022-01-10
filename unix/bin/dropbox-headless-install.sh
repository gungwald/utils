#!/bin/sh
mkdir -p "$HOME"/bin
wget "https://www.dropbox.com/download?dl=packages/dropbox.py"
chmod a+x dropbox.py
cd "$HOME"
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
.dropbox-dist/dropboxd
