#!/bin/sh

CURL_EXISTS=`which curl`

if [ -n "$CURL_EXISTS" ]
then
	curl --insecure --create-dirs --output "$HOME"/.fonts/gallant12x22.ttf \
		https://archive.org/download/gallant12x22/gallant12x22.ttf
else
	echo ERROR: Curl not found. Please install it.
fi
