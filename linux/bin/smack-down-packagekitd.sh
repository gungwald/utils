#!/bin/sh

PK_PID=`ps -ef | grep /usr/libexec/packagekitd | grep -v grep | cut --characters=11-16 -`
MAX_NICE=19
if [ -n "$PK_PID" ]
then
	sudo renice "$MAX_NICE" "$PK_PID"
else
	echo packagekitd is not running
fi
