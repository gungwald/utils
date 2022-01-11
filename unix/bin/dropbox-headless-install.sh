#!/bin/sh

# You'll want to run this from an ssh session on a system with a GUI so you
# can copy/paste the URL to authorize the machine with Dropbox.

CONTROLLER_DIR="$HOME"/bin
CONTROLLER_FILE="$CONTROLLER_DIR"/dropbox
CONTROLLER_FILE_URL="https://www.dropbox.com/download?dl=packages/dropbox.py"
SERVICE_FILE=/etc/systemd/system/dropbox@.service
SERVICE_FILE_URL="https://github.com/joeroback/dropbox/blob/bcd403fbb4e9976beb9466c427291c7249cdd787/dropbox@.service"
SERVICE=dropbox@$LOGNAME
DAEMON_URL="https://www.dropbox.com/download?plat=lnx.x86_64"
DAEMON="$HOME"/.dropbox-dist/dropboxd

if [ `id -u` -eq 0 ]
then
    echo `basename "$0"`: must be run as a regular user with sudo privileges.
    exit 1
fi

# Install dropbox controller script.
if [ -f "$CONTROLLER_FILE" ]
then
    echo $CONTROLLER_FILE is already installed.
else
    echo Installing dropbox controller script $CONTROLLER_FILE.
    mkdir -p "$CONTROLLER_DIR"
    wget --output-document="$CONTROLLER_FILE" "$CONTROLLER_FILE_URL"
    chmod a+x "$CONTROLLER_FILE"
fi

# Install/enable dropbox autostart service.
if [ -f "$SERVICE_FILE" ]
then
    echo $SERVICE_FILE is already installed.
else
    echo Installing dropbox service file $SERVICE_FILE.
    wget --output-document="$SERVICE_FILE" "$SERVICE_FILE_URL"
    echo Reloading services.
    sudo systemctl daemon-reload
    echo Enabling dropbox service: $SERVICE
    sudo systemctl enable "$SERVICE"
fi

# Install/start dropbox daemon.
if [ -f "$DAEMON" ]
then
    echo Dropbox daemon $DAEMON is already installed.
    echo To start it run: sudo systemctl start \"$SERVICE\"
else
    cd "$HOME"
    wget -O - "$DAEMON_URL" | tar xzf -
    "$DAEMON"
fi

# The above starts a process will will ask you to go to a url that has a long
# random string. You can't do it with lynx because dropbox.com requires
# JavaScript and only supports new browsers.
# I tried to set up gpm to copy and paste it but gpm won't work.
# Only option is to manually type the url on another computer.

# TODO - Set the sysctl value or whatever it is to unlimit the number of open files
