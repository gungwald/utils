@echo off

set BACKUP_DIR=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%_%TIME::=.%
echo Making backup directory %BACKUP_DIR%
mkdir %BACKUP_DIR%

