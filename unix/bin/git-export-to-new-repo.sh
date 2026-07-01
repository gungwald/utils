# Bill Chatfield
# July 1, 2026

# This is an algorithm. Execute the steps manually.

echo This script isn\'t ready to be run. Execute the steps manually.
exit

bundle=m2c.bundle
newRepo=m2c.new
oldRepo=m2c.old

cd $oldRepo

# Export the existing repo
git bundle create ../$bundle --all

cd ..

# The import (unbundling) requires a fully-initialized repo. It will create the
# new directory.
git init $newRepo
cd $newRepo

# Import the bundle.
git bundle unbundle ../$bundle
# The above does not do everything. You still need to pull in the data.
git pull ../$bundle

# Create repo on github.com but do NOT initialize it with any files. This is key
# to avoiding the error about repos with different histories:
#
#     fatal: refusing to merge unrelated histories

# Link the new local repo with the github.com repo.
git remote add origin git@github.com:gungwald/$newRepo.git
# ???
git branch -M main
# Push the data to github.com
git push -u origin main

