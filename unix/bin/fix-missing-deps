#!/bin/sh

RPM_DIR=$(mktemp --directory --suffix=-downloaded-rpms)

dnf download --downloadonly --destdir "$RPM_DIR" \
	$(dnf check | cut -d ' ' -f 6 | grep '^[^\(]*' --only-matching | sort -u)

rpm -Uvh --force "$RPM_DIR"/*.rpm

echo Please delete "$RPM_DIR" and contents manually.