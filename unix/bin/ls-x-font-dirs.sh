xset q | sed -n '/^Font/,/^ /p' | head -1 | tr , '\n'
