#!/bin/sh

# You'll want to run this from an ssh session on a system with a GUI so you
# can copy/paste the URL to authorize the machine with Dropbox.

CONTROLLER_DIR="$HOME"/bin
CONTROLLER_FILE="$CONTROLLER_DIR"/dropbox
CONTROLLER_FILE_URL="https://www.dropbox.com/download?dl=packages/dropbox.py"
SERVICE_FILE=/etc/systemd/system/dropbox@.service
SERVICE_FILE_URL="https://raw.githubusercontent.com/joeroback/dropbox/master/dropbox%40.service"
SERVICE=dropbox@$LOGNAME
DAEMON_URL="https://www.dropbox.com/download?plat=lnx.x86_64"
DAEMON="$HOME"/.dropbox-dist/dropboxd
SCRIPT=`basename "$0"`

msg()
{
    echo $SCRIPT: $*
}

if [ `id -u` -eq 0 ]
then
    msg must be run as a regular user with sudo privileges.
    exit 1
fi

# Install dropbox controller script.
if [ -f "$CONTROLLER_FILE" ]
then
    msg $CONTROLLER_FILE is already installed.
else
    msg Installing dropbox controller script $CONTROLLER_FILE.
    mkdir -p "$CONTROLLER_DIR" || exit
    wget --output-document="$CONTROLLER_FILE" "$CONTROLLER_FILE_URL" || exit
    chmod a+x "$CONTROLLER_FILE" || exit
fi

# Install/enable dropbox autostart service.
if [ -f "$SERVICE_FILE" ]
then
    msg $SERVICE_FILE is already installed.
else
    msg Installing dropbox service file $SERVICE_FILE.
    sudo wget --output-document="$SERVICE_FILE" "$SERVICE_FILE_URL" || exit
    msg Reloading services.
    sudo systemctl daemon-reload || exit
    msg Enabling dropbox service: $SERVICE
    sudo systemctl enable "$SERVICE" || exit
fi

# Install/start dropbox daemon.
if [ -f "$DAEMON" ]
then
    msg Dropbox daemon $DAEMON is already installed.
else
    cd "$HOME"
    wget -O - "$DAEMON_URL" | tar xzf -
    "$DAEMON"
fi

msg To start dropbox run: sudo systemctl start $SERVICE

# The above starts a process will will ask you to go to a url that has a long
# random string. You can't do it with lynx because dropbox.com requires
# JavaScript and only supports new browsers.
# I tried to set up gpm to copy and paste it but gpm won't work.
# Only option is to manually type the url on another computer.

# TODO - Set the sysctl value or whatever it is to unlimit the number of open files
