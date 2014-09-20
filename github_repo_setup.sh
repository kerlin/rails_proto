#!/bin/bash

if [ -d ./.git ] && [ -s ./.git/config ]
then
  echo "Detected initialized git repository"
else
  echo "Exiting - Not an initialized git repository"
  exit
fi;

GIT_USER=`git config --get user.name`
GIT_PROJ=$(basename `pwd`)

# this just updates .git/config - you must also add repo on github web site!
echo "git remote add origin git@github.com:$GIT_USER/$GIT_PROJ.git"
git remote add origin git@github.com:$GIT_USER/$GIT_PROJ.git
#git remote add origin https://github.com/$GIT_USER/$GIT_PROJ.git
git remote -v
