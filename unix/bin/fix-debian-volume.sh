#!/bin/sh
# For some reasons this defaults to 0%. It must be increased to hear
# sound.
amixer -c 0 cset numid=1,iface=MIXER,name='Headphone Playback Volume' 80
