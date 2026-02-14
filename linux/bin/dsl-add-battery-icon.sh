#!/bin/sh

# Install the necessary icons and the battery app.
sudo apt install adwaita-icon-theme-antix cbatticon

# Add startup of the battery icon app when the user logs in.
cat << EOF > ~/.desktop-session/startup
## Added by user $USER on $(date '+%F'): This adds a battery icon to
## the taskbar. It requires the packages adwaita-icon-theme-antix and
## cbatticon to be installed.
cbatticon &
EOF
