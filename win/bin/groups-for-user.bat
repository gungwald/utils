@echo off
if "%1"=="" (
	echo Assuming current user %USERNAME%
	net user %USERNAME% /domain
) else (
	net user %1 /domain
)

