#!/bin/bash

# Special thanks to http://willandorla.com/will/2011/01/convert-folder-into-git-submodule

function usage(){
  echo "Usage:"
  echo "	`basename $0` -m mod -u url"
  echo
  echo "		-m mod		new submodule name"
  echo "		-u url		new submodule repository url"
  echo
  echo
  echo "Example:"
  echo "	foo/aaa"
  echo "	foo/bbb"
  echo "	foo/ccc"
  echo "	foo/ddd"
  echo "	foo/bar/zzz"
  echo "	foo/bar/yyy"
  echo "	foo/bar/xxx"
  echo "	foo/bar/www"
  echo
  echo "If you want to subdirectory 'bar' to git submodule, you can execute following command:"
  echo
  echo "	`basename $0` -m bar -u https://github.com/kewangtw/bar.git"
}

if [ $# -ne 5 ]; then
  usage

  exit 1
fi

ORIG_PWD=`pwd`
MOD_NAME=$2
MOD_REPO_URL=$4

# Clone new repositories.
mkdir -p /tmp/dir2mod/

git clone --no-hardlinks . /tmp/dir2mod/$MOD_NAME

# Filter out the files you want to keep and remove the others.
cd /tmp/dir2mod/$MOD_NAME

git filter-branch --subdirectory-filter $MOD_NAME HEAD -- --all
git reset --hard
git gc --aggressive
git prune
git remote rm origin

# Push the new repositories to the upstream server.
git remote add origin $MOD_REPO_URL
git push -u origin master

# Add the new repository as submodules to the original repository
cd $ORIG_PWD

git rm -r $MOD_NAME
git commit -m "Removing the folders that are now repositories"
git submodule add $MOD_REPO_URL $MOD_NAME
git submodule init
git submodule update
git add .
git commit -m "Added in submodules for removed folders"
git push

rm -rf /tmp/dir2mod/$MOD_NAME
