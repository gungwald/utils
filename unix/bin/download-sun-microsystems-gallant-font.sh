#!/bin/sh

# Downloads both the TTF and the bitmapped fonts. And it sets them up.

# Gallant is the font used by the console of Sun Microsystems' workstations.

# This script sticks to older ways of doing things and older parameters
# so that it continues to work on older operating systems and hardware.

getFontDirList()
{
    # Can't find ways to make this more efficient and still work in BSD.
    xset q | sed -n '/^Font/,/^ /p' | sed -n '2,$p' | sed 's/^  //' | tr , '\n'
}

isInFontDirList()
{
    # This works even if the caller forgot to provide the first argument.
    getFontDirList | grep "^$1\$" >/dev/null
}

downloadGallantBitmapFont()
(
    REMOTE_URL='https://github.com/NanoBillion/gallant/raw/refs/heads/main/gallant.pcf.gz'
    LOCAL_DIR="$HOME"/.fonts-pcf
    LOCAL_FILE="$LOCAL_DIR"/gallant.pcf.gz
    RESPONSE_HEADER_FILE="$HOME"/response-headers-for-sun-console-font-download-bitmap.txt
    XSESS="$HOME"/.xsession

    # Download the font file directly into the new font direcoty.
    if [ -f "$LOCAL_FILE" ]
    then
        echo Bitmap font file already exists so skipping download.
    else
        echo Downloading bitmap font to $LOCAL_FILE.
        # --location says to follow redirects
        # --create-dirs is used so this doesn't have to be done manually.
	curl --insecure --location --dump-header "$RESPONSE_HEADER_FILE" \
	  --progress-bar --create-dirs \
	  --output "$LOCAL_FILE" "$REMOTE_URL" || exit
        cd "$LOCAL_DIR" || exit
        mkfontdir || exit
    fi

    # Add new font directory to the current run-time directory list.
    if isInFontDirList "$LOCAL_DIR"/
    then
        echo Bitmap font directory already configured so skipping setup.
    else
        chmod o+rx "$LOCAL_DIR" || exit
        xset +fp "$LOCAL_DIR"/ || exit
        xset fp rehash || exit
        echo Added $LOCAL_DIR to font directories.
    fi

    # Make .xsession always setup new font directory.    
    if grep "xset +fp \"$LOCAL_DIR\"" "$XSESS" >/dev/null
    then
        echo .xsession already configured so skipping.
    else
        if [ -f "$XSESS".backup ]
        then
            echo $XSESS.backup already exists. Cannot continue. 1>&2
            echo Check that $XSESS is not corrupted or empty 1>&2
            echo then you can delete $XSESS.backup and try again. 1>&2
            exit 1
        else
            cp "$XSESS" "$XSESS".backup
            # Concat stdin-heredoc, existing .xsession and write to new file.
            # The additional lines cannot be put at the end because the script
            # stops when the window manager is run with "exec".
            cat - "$XSESS" >"$XSESS".new <<EOF
xset +fp "$LOCAL_DIR"/
xset fp rehash
EOF
            mv "$XSESS".new "$XSESS"
            echo $XSESS updated to add $LOCAL_DIR to font directories.
        fi
    fi     
    # xterm -fa '' -fn "-sun-gallant-medium-r-normal-*-22-*-*-*-*-80-*-*"
)

downloadGallantTtfFont()
(
    REMOTE_URL='https://archive.org/download/gallant12x22/gallant12x22.ttf'
    LOCAL_DIR="$HOME"/.fonts
    LOCAL_FILE="$LOCAL_DIR"/gallant12x22.ttf
    RESPONSE_HEADER_FILE="$HOME"/response-headers-for-sun-console-font-download.txt

    if [ -f "$LOCAL_FILE" ]
    then
        echo TTF font file already exists so skipping download.
    else
        # --location says to follow redirects
	curl --insecure --location --dump-header "$RESPONSE_HEADER_FILE" \
	  --progress-bar --create-dirs \
	  --output "$LOCAL_FILE" "$REMOTE_URL"
          
        # Rebuild font cache so that it finds the new font.
        fc-cache -f -v
    fi
)

#######
# Main 
#######

downloadGallantBitmapFont || exit
downloadGallantTtfFont
