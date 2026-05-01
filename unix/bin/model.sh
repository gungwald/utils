#!/bin/sh

OS=`uname -s`

case "$OS" in
	Linux)
		sudo dmidecode -s system-product-name
		;;
		
	OpenBSD)
		sysctl hw.vendor hw.product hw.model hw.machine hw.ncpu hw.physmem hw.byteorder
		;;
	*)
		echo Unknown $OS
		;;
esac

