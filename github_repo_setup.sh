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

echo "git remote add origin git@github.com:$GIT_USER/$GIT_PROJ.git"
git remote add origin git@github.com:$GIT_USER/$GIT_PROJ.git
