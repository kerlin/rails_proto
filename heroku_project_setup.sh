#!/bin/bash

# Run in once in each project directory on host

# Prerequisites
# git clone project, or rails new project
# http://git-scm.com/docs/git-clone
# http://gitref.org/creating/
# note: clone downloads a copy of the repo and checks out active branch
# no authentication
# git clone https://github.com/heroku/ruby-rails-sample.git
# most efficient requires daemon-export-ok file
# git clone git://github.com/heroku/ruby-rails-sample.git
# requires authentication
# git clone git@github.com:heroku/ruby-rails-sample.git
# cd project
# git init

if whoami | grep vagrant >/dev/null
then
  echo "Run this script on host"
  exit
else
  echo "Ok, running on host"
fi

if [ -d ./.git ] && [ -s ./.git/config ]
then
  echo "Detected initialized git repository"
else
  echo "Exiting - Not an initialized git repository"
  exit
fi;

PROJ=$(basename `pwd`)

# Set up heroku.
# - devcenter.heroku.com/articles/config-vars
# - devcenter.heroku.com/articles/heroku-postgresql
# executing heroku login writes to ~/.netrc to authenticate future access
# only do it once
# https://devcenter.heroku.com/articles/authentication
if grep 'heroku.com' ~/.netrc > /dev/null
then
  echo "Heroku authentication configured"
else
  echo "\n\nNOW ENTER YOUR HEROKU PASSWORD"
  heroku login
  if  ssh -v git@heroku.com | grep "Authentication succeeded (publickey)" > /dev/null
  then 
    echo "Heroku authentication passed."
  else
    exit
  fi
fi

heroku create kerlin-${PROJ}-dev
echo "\nCreate staging and production? (y/n)"
read STGPROD
if [ $STGPROD == "y" ]
then
  heroku create kerlin-${PROJ}-staging --remote staging-heroku
  heroku create kerlin-${PROJ}-production --remote production-heroku
fi

#database plan :dev is first gen legacy
#heroku addons:add heroku-postgresql:dev
# probably the default, hobby-dev is free
heroku addons:add heroku-postgresql:hobby-dev
# set primary database
# not necessary if we only have the one. Would there be a sqlite3 db there?
# https://devcenter.heroku.com/articles/heroku-postgresql
#heroku pg:promote `heroku config  | grep HEROKU_POSTGRESQL | cut -f1 -d':'`

