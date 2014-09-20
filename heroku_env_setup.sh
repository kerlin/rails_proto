#!/bin/bash

# Run only once on host

if whoami | grep vagrant >/dev/null
then
  echo "Run this script on host"
  exit
else
  echo "Ok, running on host"
fi

cd ~

# see help set
# -e exit immediately if a command exits with a non-zero status.
set -e

# Install Heroku toolbelt
# Includes Heroku client, Foreman, and Git
# https://toolbelt.heroku.com/debian
# https://devcenter.heroku.com/articles/heroku-command
# http://railsapps.github.io/rails-heroku-tutorial.html
# with this, don't put gem "heroku" in the Gemfile
if uname -a | grep Darwin > /dev/null
then
 # Mac OS X
 echo "Install from https://toolbelt.heroku.com/osx"
else
  # Debian/Ubuntu
  wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

heroku --version
which heroku

# Set up heroku.
# - devcenter.heroku.com/articles/config-vars
# - devcenter.heroku.com/articles/heroku-postgresql
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

if [ ! -s ~/.ssh/id_rsa.pub ]
then
  ssh-keygen -t rsa -C "chris.kerlin@gmail.com"
fi
heroku keys:add
# see https://github.com/ddollar/heroku-config
# with .env in .gitignore, use heroku config:pull for secrets like
# SECRET_KEY_BASE for rails, and api keys for other apps
heroku plugins:install git://github.com/ddollar/heroku-config.git

