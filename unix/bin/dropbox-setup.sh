#!/bin/sh

sudo cat > /etc/yum.repos.d/dropbox.repo <<HEREDOC
[dropbox]
name=Dropbox Repository
baseurl=https://linux.dropbox.com/fedora/\$releasever/
gpgkey=https://linux.dropbox.com/fedora/rpm-public-key.asc
HEREDOC

[ $? -ne 0 ] && exit

sudo dnf install -y nautilus-dropbox
