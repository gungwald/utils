#!/bin/sh

doas pkg_add gnome
doas rcctl disable xenodm
doas rcctl enable multicast messagebus avahi_daemon gdm
doas reboot
