#!/bin/sh

# Desc:Creates a remote github repo with the contents of a local git repo.

MY_TOKEN_FILE="$HOME"/Dropbox/.github/readonly-token.txt

if [ -f "$MY_TOKEN_FILE" ]
then
    export GH_TOKEN=`cat "$MY_TOKEN_FILE"`
else
    gh auth login
fi

# Run this at the top directory of a local git repo. The remote github name 
# will be the name of the source directory.
gh repo create --public --source "$PWD" --push

