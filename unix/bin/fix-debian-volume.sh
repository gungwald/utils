#!/bin/sh

# For some reason, one or all of these settings default to 0%. They must be
# increased to hear sound.

# To find out what control is set to 0, run alsamixer and press F6 to select
# the real sound card. Then go through all the controls, increasing them while
# having the computer "try" to play sound. When you increase the value of a
# control and start to hear sound, you have found the setting that Debian
# screwed up and set to 0. Then run "amixer -c 0 controls" to find the
# matching definition of the control which can be used with a command line
# like the below commands.

# The card number always appears to be 0. I guess this actually specifies the
# physical sound card number. That's suprising with all the silly unnecessary
# layers in the Linux sound system. It seems like the device file should be
# the correct thing to specify instead of a number.
CARD_NUMBER=0
DESIRED_VOLUME="80%"

# Both of these controls have been the source of the "no sound" problem on 
# actual Debian installs.
HEADPHONE_VOLUME_CTRL="numid=1,iface=MIXER,name='Headphone Playback Volume'"
PCM_VOLUME_CTRL="numid=3,iface=MIXER,name='PCM Playback Volume'"

for CTRL in "$HEADPHONE_VOLUME_CTRL" "$PCM_VOLUME_CTRL"
do
    amixer -c "$CARD_NUMBER" cset "$CTRL" "$DESIRED_VOLUME"
done

