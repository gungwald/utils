#!/bin/sh

whichOutput=`which curl`
if [ -n "$whichOutput" ]; then
  curl --insecure --create-dirs --output "$HOME"/.fonts/gallant12x22.ttf https://www.mortec.com.wstub.archive.org/download/gallant12x22/gallant12x22.ttf
else
  echo $0: no curl to do the download with
fi
