@echo off

set /p ANSWER=Use business e-mail address? (y/n)

if "%ANSWER%"=="y" (
    git config --global user.email "bill.chatfield@cardinalhealth.com"
) else (
    git config --global user.email "bill_chatfield@yahoo.com"
)

rem Always the same
git config --global user.name "Bill Chatfield"

rem Turn on user and password storage.
git config --global credential.helper store

rem Set to Windows functionality: convert LF to CRLF on checkout, convert CRLF to LF on commit.
git config --global core.autocrlf true
