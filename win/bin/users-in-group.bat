@echo off
if "%1"=="" (
	echo Please provide the group name
) else (
	net group %1 /domain
)

