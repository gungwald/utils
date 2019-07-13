#!/bin/sh

. /etc/os-release || exit 1

if [ "$ID_LIKE" = 'fedora' -o $ID = 'fedora' -o $ID = 'rhel' -o $ID = 'centos' ]
then
	rpm -q -f "$@"
elif [ "$ID_LIKE" = 'debian' ]
then
	dpkg-query --search "$@"
else
	echo Unrecognized system: ID=$ID ID_LIKE=$ID_LIKE
fi
