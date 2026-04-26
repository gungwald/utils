#!/bin/sh
xset q | sed -n '/^Font/,/^ /p' | sed -n '2,$p' | sed 's/^  //'|tr , '\n'
