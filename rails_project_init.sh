#!/bin/bash

# Create a new rails project on vagrant

if whoami | grep vagrant >/dev/null
then
  echo "Ok, running on vagrant"
else
  echo "Run this script on vagrant"
  exit
fi

cd ..
# create an empty rails project
rails new PROJECT_DIR -T -d postgresql
# create a test project
# git clone https://github.com/heroku/ruby-rails-sample.git

