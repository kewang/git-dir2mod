#!/bin/bash

# Special thanks to http://willandorla.com/will/2011/01/convert-folder-into-git-submodule

# $1 original repository
# $2 new submodule name
# $3 want to change dir
# $4 new submodule repository name

read -p "Please input original repository folder: " ORIG_REPO_FOLDER
read -p "Please input new submodule name: " NEW_MOD_NAME
read -p "Please input want to change folder name: " DIR_NAME
read -p "Please input new submodule repository url: " NEW_MOD_REPO_URL

# Clone new repositories.
git clone --no-hardlinks $ORIG_REPO_FOLDER $NEW_MOD_NAME

# Filter out the files you want to keep and remove the others.
cd $NEW_MOD_NAME
git filter-branch --subdirectory-filter $DIR_NAME HEAD -- --all
git reset --hard
git gc --aggressive
git prune
git remote rm origin

# Push the new repositories to the upstream server.
git remote add origin $NEW_MOD_REPO_URL
git push -u origin master

# Add the new repository as submodules to the original repository
cd ../$ORIG_REPO_FOLDER
git rm -r $DIR_NAME
git commit -m "Removing the folders that are now repositories"
git submodule add $NEW_MOD_REPO_URL $DIR_NAME
git submodule init
git submodule update
git add .
git commit -m "Added in submodules for removed folders"
git push
