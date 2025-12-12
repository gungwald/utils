#!/bin/sh

# Desc:Creates a remote github repo with the contents of a local git repo.

# Run this at the top directory of a local git repo. The remote github name 
# will be the name of the source directory.
gh repo create --public --source "$PWD" --push
