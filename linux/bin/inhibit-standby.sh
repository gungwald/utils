#!/bin/sh

# Inhibits standby mode when logging in remotely to a Linux system with
# the accursed systemd. Needs to be put in .profile or .bashrc

SELF=$(basename "$0")

if [ "$SSH_CLIENT" ] && ! pstree -ps $$ | grep -q -- '-systemd-inhibit('
then
  echo "$SELF: Inhibiting automatic standby"
  exec /usr/bin/systemd-inhibit                \
            --what=idle                        \
            --why='Interactive SSH Session' -- \
            "$SHELL" "$@"
fi
